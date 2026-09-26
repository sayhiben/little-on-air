"""The build guard must fail closed when the pinned dependency changes."""
import importlib.util
from pathlib import Path
import unittest

root = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location(
    "nimble_guard", root / "apps/controller-esp32s3/nimble_guard.py")
guard = importlib.util.module_from_spec(spec)
spec.loader.exec_module(guard)


class GuardTests(unittest.TestCase):
    def test_only_missing_key_branch_changes(self):
        source = "before\n" + guard.ORIGINAL + "\nbody\n}\nafter\n"
        patched = guard.guarded_source(source)
        self.assertEqual(patched.replace(guard.GUARDED, guard.ORIGINAL), source)
        self.assertNotIn(guard.ORIGINAL, patched)
        self.assertIn("if (0 && res->app_status == 518 )", patched)

    def test_changed_or_duplicate_handler_refuses_build(self):
        for source in ("", guard.ORIGINAL * 2, guard.ORIGINAL.replace("518", "519")):
            with self.assertRaises(RuntimeError):
                guard.guarded_source(source)


unittest.main()
