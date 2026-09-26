"""Small local MCP client for the Fusion server explicitly selected for this project."""
import argparse
import base64
import json
from pathlib import Path
import urllib.request

URL = "http://127.0.0.1:27182/mcp"


class FusionClient:
    def __init__(self):
        self.session = None
        self.serial = 0
        self.request("initialize", {
            "protocolVersion": "2024-11-05", "capabilities": {},
            "clientInfo": {"name": "little-on-air-enclosure", "version": "1.0"},
        })
        self.request("notifications/initialized", {}, notification=True)

    def request(self, method, params, notification=False):
        self.serial += 1
        payload = {"jsonrpc": "2.0", "method": method, "params": params}
        if not notification:
            payload["id"] = self.serial
        headers = {"Content-Type": "application/json", "Accept": "application/json, text/event-stream"}
        if self.session:
            headers["MCP-Session-Id"] = self.session
        req = urllib.request.Request(URL, json.dumps(payload).encode(), headers)
        with urllib.request.urlopen(req, timeout=600) as response:
            self.session = response.headers.get("MCP-Session-Id", self.session)
            raw = response.read().decode()
        if not raw:
            return {}
        data = json.loads(raw)
        if "error" in data:
            raise RuntimeError(json.dumps(data["error"]))
        return data.get("result", data)

    def call(self, name, arguments):
        result = self.request("tools/call", {"name": name, "arguments": arguments})
        if result.get("isError"):
            raise RuntimeError(json.dumps(result, indent=2))
        return result


def unpack(result):
    blocks = result.get("content", [])
    if len(blocks) == 1 and blocks[0].get("type") == "text":
        try:
            return json.loads(blocks[0]["text"])
        except ValueError:
            return blocks[0]["text"]
    return result


def main():
    parser = argparse.ArgumentParser()
    sub = parser.add_subparsers(dest="action", required=True)
    p = sub.add_parser("docs")
    p.add_argument("pattern")
    p.add_argument("--filter")
    p.add_argument("--category", default="member")
    p = sub.add_parser("run")
    p.add_argument("path")
    p = sub.add_parser("stage")
    p.add_argument("name")
    p = sub.add_parser("screenshot")
    p.add_argument("path")
    p.add_argument("--direction", default="current")
    sub.add_parser("documents")
    parser.add_argument("--output")
    args = parser.parse_args()
    client = FusionClient()
    if args.action == "docs":
        params = {"queryType": "apiDocumentation", "searchPattern": args.pattern, "apiCategory": args.category}
        if args.filter:
            params["filter"] = args.filter
        result = client.call("fusion_mcp_read", params)
    elif args.action == "documents":
        result = client.call("fusion_mcp_read", {"queryType": "document", "operation": "open"})
    elif args.action in ("run", "stage"):
        if args.action == "run":
            source_path = Path(args.path).resolve()
            script = f"__file__ = {source_path.as_posix()!r}\n" + source_path.read_text(encoding="utf-8")
        else:
            builder = Path(__file__).with_name("build_enclosure.py").resolve().as_posix()
            script = ("import importlib.util\n"
                      "def run(_context: str):\n"
                      f"    spec = importlib.util.spec_from_file_location('loa_enclosure_builder', {builder!r})\n"
                      "    mod = importlib.util.module_from_spec(spec)\n"
                      "    spec.loader.exec_module(mod)\n"
                      f"    mod.run_stage({args.name!r})\n")
        result = client.call("fusion_mcp_execute", {"featureType": "script", "object": {"script": script}})
    else:
        result = client.call("fusion_mcp_read", {"queryType": "screenshot", "direction": args.direction,
                             "width": 1600, "height": 1100, "transparentBackground": False})
        data = unpack(result)
        if isinstance(data, dict) and "base64Data" in data:
            content = data["base64Data"]
        else:
            content = next(b["data"] for b in result["content"] if b["type"] == "image")
        path = Path(args.path)
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(base64.b64decode(content))
        print(path.resolve())
        return
    value = unpack(result)
    if isinstance(value, dict) and value.get("success") is False:
        raise RuntimeError(json.dumps(value, indent=2))
    output = value if isinstance(value, str) else json.dumps(value, indent=2)
    if args.output:
        path = Path(args.output)
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(output, encoding="utf-8")
        print(path.resolve())
    else:
        print(output)


if __name__ == "__main__":
    main()
