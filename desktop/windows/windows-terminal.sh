#!/usr/bin/env bash
set -euo pipefail
[[ -n "${WSL_DISTRO_NAME:-}" ]] || {
    echo "Windows Terminal setup requires WSL." >&2
    exit 1
}
d="$(cd "$(dirname "$0")" && pwd)"
for tool in powershell.exe wslpath python3; do
    command -v "$tool" >/dev/null || {
        echo "Required for Windows Terminal setup: $tool" >&2
        exit 1
    }
done
font_script="$(wslpath -w "$d/install-font.ps1")"
if ! powershell.exe -NoProfile -NonInteractive -File "$font_script"; then
    echo "WARNING: Optional Windows font installation failed; continuing with Terminal profile configuration. Fonts may need manual installation. If PowerShell blocked the script, use an IT-approved or signed version; execution policy was not changed." >&2
fi
python3 "$d/apply.py" --distro "$WSL_DISTRO_NAME"
