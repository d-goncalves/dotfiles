#!/usr/bin/env python3
import copy
import argparse
import json
import shutil
import subprocess
import uuid
from datetime import datetime
from pathlib import Path

FONT_FACE = "FiraCode Nerd Font Mono"   # installed by install-font.ps1
FONT_SIZE = 11


def main(argv=None):
    parser = argparse.ArgumentParser()
    parser.add_argument("--distro", help="Ensure this WSL distro has a configured profile")
    args = parser.parse_args(argv)
    dotfiles = Path(__file__).resolve().parents[2]
    # One source of truth for the colors, shared with iTerm: desktop/palette.json
    scheme = json.loads((dotfiles / "desktop/palette.json").read_text())
    local_appdata = subprocess.run(
        [
            "powershell.exe", "-NoProfile", "-NonInteractive", "-Command",
            "[Environment]::GetFolderPath('LocalApplicationData')",
        ],
        check=True, capture_output=True, text=True,
    ).stdout.strip()
    root = Path(subprocess.run(
        ["wslpath", "-u", local_appdata],
        check=True, capture_output=True, text=True,
    ).stdout.strip()) / "Packages"
    suffixes = (
        "Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json",
        "Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json",
    )
    targets = [root / suffix for suffix in suffixes]
    targets = [path for path in targets if path.is_file()]
    if not targets:
        raise SystemExit("No Windows Terminal settings.json found for the current Windows user")

    updated = []
    for path in targets:
        original = path.read_text(encoding="utf-8-sig")
        data = json.loads(original)
        schemes = data.setdefault("schemes", [])
        matches = [i for i, item in enumerate(schemes) if item.get("name") == scheme["name"]]
        if matches:
            schemes[matches[0]] = copy.deepcopy(scheme)
            for i in reversed(matches[1:]):
                del schemes[i]
        else:
            schemes.append(copy.deepcopy(scheme))

        profiles = data.setdefault("profiles", {}).setdefault("list", [])
        if args.distro and not any(profile.get("name") == args.distro for profile in profiles):
            profiles.append({
                "name": args.distro,
                "guid": "{" + str(uuid.uuid4()) + "}",
                "commandline": subprocess.list2cmdline(["wsl.exe", "-d", args.distro]),
                "hidden": False,
            })
        for profile in profiles:
            if args.distro and profile.get("name") == args.distro:
                profile["commandline"] = subprocess.list2cmdline(
                    ["wsl.exe", "-d", args.distro, "--cd", "~"]
                )
            if profile.get("name", "").startswith("Ubuntu") or (
                args.distro and profile.get("name") == args.distro
            ):
                profile["colorScheme"] = scheme["name"]
                profile["font"] = {
                    "face": FONT_FACE,
                    "size": profile.get("font", {}).get("size", FONT_SIZE),
                    "weight": "normal",
                }
                profile["adjustIndistinguishableColors"] = "always"
                profile["intenseTextStyle"] = "bright"

        output = json.dumps(data, indent=4, ensure_ascii=False) + "\n"
        if data == json.loads(original):
            continue
        backup = path.with_name(
            f"settings.json.bak-dotfiles-{datetime.now().strftime('%Y%m%d%H%M%S%f')}"
        )
        shutil.copyfile(path, backup)
        path.write_text(output, encoding="utf-8")
        updated.append(path)

    for path in updated:
        print(f"Updated {path}")


if __name__ == "__main__":
    main()
