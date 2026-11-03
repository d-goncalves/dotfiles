#!/usr/bin/env python3
"""Build the iTerm2 color settings from desktop/palette.json, so the terminals never drift.

Reads desktop/palette.json (one color scheme, in Windows Terminal's format) and writes its colors (and name) into the
iTerm2 Dynamic Profile, leaving everything else in that profile (font, ligatures, GUID) alone.

    python3 desktop/macos/make-iterm-profile.py       # update the profile in place
    python3 desktop/macos/make-iterm-profile.py --check # exit 1 if the profile is out of date
"""
import argparse
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SCHEME_FILE = ROOT / "desktop/palette.json"
PROFILE_FILE = ROOT / "desktop/macos/Library/Application Support/iTerm2/DynamicProfiles/vivid-black.json"

ANSI = ["black", "red", "green", "yellow", "blue", "purple", "cyan", "white"]


def color(hex_value):
    r, g, b = (int(hex_value.lstrip("#")[i:i + 2], 16) / 255 for i in (0, 2, 4))
    return {"Red Component": r, "Green Component": g, "Blue Component": b,
            "Alpha Component": 1, "Color Space": "sRGB"}


def colors_for(scheme):
    out = {}
    for i, name in enumerate(ANSI):
        out[f"Ansi {i} Color"] = color(scheme[name])
        out[f"Ansi {i + 8} Color"] = color(scheme["bright" + name.capitalize()])
    out["Background Color"] = color(scheme["background"])
    out["Foreground Color"] = color(scheme["foreground"])
    out["Bold Color"] = color(scheme["foreground"])
    out["Cursor Color"] = color(scheme["cursorColor"])
    out["Cursor Text Color"] = color(scheme["background"])
    out["Selection Color"] = color(scheme["selectionBackground"])
    out["Selected Text Color"] = color(scheme["brightWhite"])
    # iTerm builds a dynamic profile on top of the user's Default profile, so anything not set here is
    # inherited. If Default uses separate light/dark colors, those would win over the colors above.
    # Switch that off, and also write the same colors for both modes so nothing can be inherited.
    for key in list(out):
        out[key + " (Light)"] = out[key]
        out[key + " (Dark)"] = out[key]
    out["Use Separate Colors for Light and Dark Mode"] = False
    return out


def main(argv=None):
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true", help="only report whether the profile is up to date")
    args = parser.parse_args(argv)

    scheme = json.loads(SCHEME_FILE.read_text())
    data = json.loads(PROFILE_FILE.read_text())
    profile = data["Profiles"][0]
    updated = dict(profile)
    updated.update(colors_for(scheme))
    updated["Name"] = scheme["name"]

    if updated == profile:
        print(f"iTerm profile already matches '{scheme['name']}'")
        return 0
    if args.check:
        print(f"iTerm profile is out of date with '{scheme['name']}'; run desktop/macos/make-iterm-profile.py", file=sys.stderr)
        return 1
    data["Profiles"][0] = updated
    PROFILE_FILE.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n")
    print(f"Updated {PROFILE_FILE.relative_to(ROOT)} from '{scheme['name']}'")
    return 0


if __name__ == "__main__":
    sys.exit(main())
