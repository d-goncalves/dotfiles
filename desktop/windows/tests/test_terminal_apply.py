import importlib.util
import json
import subprocess
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch


SCRIPT = Path(__file__).resolve().parents[1] / "apply.py"
spec = importlib.util.spec_from_file_location("terminal_apply", SCRIPT)
terminal_apply = importlib.util.module_from_spec(spec)
spec.loader.exec_module(terminal_apply)


class TerminalApplyTests(unittest.TestCase):
    def test_preserves_settings_and_does_not_rewrite_on_rerun(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            settings = (
                root / "Packages" / "Microsoft.WindowsTerminal_8wekyb3d8bbwe"
                / "LocalState" / "settings.json"
            )
            settings.parent.mkdir(parents=True)
            original = {
                "launchMode": "maximizedFocus",
                "defaultProfile": "keep-this-profile",
                "profiles": {"list": [
                    {"name": "Ubuntu-26.04", "font": {"size": 14},
                     "startingDirectory": "C:\\Users\\example"},
                    {"name": "PowerShell", "colorScheme": "Unchanged"},
                ]},
            }
            settings.write_text(json.dumps(original))
            responses = [
                subprocess.CompletedProcess([], 0, stdout="C:\\Users\\example\\AppData\\Local\n"),
                subprocess.CompletedProcess([], 0, stdout=f"{root}\n"),
            ]
            with patch.object(terminal_apply.subprocess, "run", side_effect=responses), \
                    patch.object(terminal_apply.shutil, "copystat", side_effect=PermissionError):
                terminal_apply.main(["--distro", "Ubuntu-26.04"])
            result = json.loads(settings.read_text())
            self.assertEqual(result["launchMode"], original["launchMode"])
            self.assertEqual(result["defaultProfile"], original["defaultProfile"])
            self.assertEqual(result["profiles"]["list"][1], original["profiles"]["list"][1])
            self.assertEqual(result["profiles"]["list"][0]["font"]["size"], 14)
            self.assertEqual(result["profiles"]["list"][0]["colorScheme"], "Vivid Black")
            self.assertEqual(
                result["profiles"]["list"][0]["commandline"],
                "wsl.exe -d Ubuntu-26.04 --cd ~",
            )
            first_mtime = settings.stat().st_mtime_ns
            with patch.object(terminal_apply.subprocess, "run", side_effect=responses):
                terminal_apply.main(["--distro", "Ubuntu-26.04"])
            self.assertEqual(settings.stat().st_mtime_ns, first_mtime)
            self.assertEqual(len(list(settings.parent.glob("*.bak-dotfiles-*"))), 1)

    def test_missing_current_user_settings_fails(self):
        with tempfile.TemporaryDirectory() as directory:
            responses = [
                subprocess.CompletedProcess([], 0, stdout="C:\\Users\\example\\AppData\\Local\n"),
                subprocess.CompletedProcess([], 0, stdout=f"{directory}\n"),
            ]
            with patch.object(terminal_apply.subprocess, "run", side_effect=responses):
                with self.assertRaisesRegex(SystemExit, "current Windows user"):
                    terminal_apply.main([])

    def test_creates_missing_distro_profile_once(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            settings = (
                root / "Packages" / "Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe"
                / "LocalState" / "settings.json"
            )
            settings.parent.mkdir(parents=True)
            settings.write_text('{"defaultProfile": "keep", "profiles": {"list": []}}')
            responses = [
                subprocess.CompletedProcess([], 0, stdout="C:\\Users\\example\\AppData\\Local\n"),
                subprocess.CompletedProcess([], 0, stdout=f"{root}\n"),
            ]
            for _ in range(2):
                with patch.object(terminal_apply.subprocess, "run", side_effect=responses):
                    terminal_apply.main(["--distro", "Ubuntu-26.04"])
            data = json.loads(settings.read_text())
            self.assertEqual(data["defaultProfile"], "keep")
            self.assertEqual(len(data["profiles"]["list"]), 1)
            profile = data["profiles"]["list"][0]
            self.assertEqual(profile["commandline"], "wsl.exe -d Ubuntu-26.04 --cd ~")
            self.assertEqual(profile["font"]["face"], "JetBrainsMono Nerd Font")


if __name__ == "__main__":
    unittest.main()
