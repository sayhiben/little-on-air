"""Keep NimBLE 2.5.1 missing-key errors on the explicit-pairing path.

Compile a generated copy; never edit PlatformIO's downloaded library. The
bundled host retries pairing on status 518 before notifying any GAP listener.
Disabling that branch lets its normal error cleanup notify our bond guard.
"""
from pathlib import Path

ORIGINAL = "        if (res->app_status == 518 ) {"
GUARDED = "        if (0 && res->app_status == 518 ) { /* LOA: explicit pairing only. */"


def guarded_source(source):
    if source.count(ORIGINAL) != 1:
        raise RuntimeError("NimBLE missing-key handler changed; review the pairing guard")
    return source.replace(ORIGINAL, GUARDED)


def compile_guarded_host(env, node):
    original = Path(node.srcnode().get_abspath())
    library = next(p for p in original.parents if p.name == "NimBLE-Arduino")
    if "version=2.5.1" not in (library / "library.properties").read_text().splitlines():
        raise RuntimeError("Pairing guard requires reviewed NimBLE-Arduino 2.5.1")
    generated = Path(env.subst("$BUILD_DIR")) / "loa_nimble_guard" / "ble_sm.c"
    generated.parent.mkdir(parents=True, exist_ok=True)
    contents = guarded_source(original.read_text())
    if not generated.exists() or generated.read_text() != contents:
        generated.write_text(contents)
    return env.Object(
        str(generated),
        CPPPATH=env["CPPPATH"] + [str(original.parent)],
    )


try:
    Import("env")
except NameError:
    pass  # Importable by the host regression test.
else:
    env.AddBuildMiddleware(compile_guarded_host, "*/ble_sm.c")
