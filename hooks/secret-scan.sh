#!/usr/bin/env bash
# Shared by the pre-commit and pre-push hooks: reads a unified diff on stdin and exits 1 when an
# added line looks like a credential, or when a file that should never be committed is added.
# This repo is public, so a blocked commit is cheaper than a leaked token. Values are never printed.
set -u

# Specific, low-noise token shapes (GitHub, AWS, Slack, Google, JWT, private keys, user:token@host URLs)
PATTERN='(gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|AKIA[0-9A-Z]{16}|ASIA[0-9A-Z]{16}|xox[baprs]-[A-Za-z0-9-]{10,}|AIza[0-9A-Za-z_-]{30,}|-----BEGIN [A-Z ]*PRIVATE KEY|eyJ[A-Za-z0-9_-]{15,}\.[A-Za-z0-9_-]{15,}\.[A-Za-z0-9_-]{10,}|https?://[^/[:space:]:@]+:[^/[:space:]@]{8,}@)'
# Files that carry secrets by nature
BANNED_FILES='(^|/)(\.[A-Za-z_]*_history|\.lesshst|\.viminfo|\.env|\.env\..*|\.netrc|\.npmrc|\.pypirc|id_(rsa|dsa|ecdsa|ed25519)|.*\.(pem|p12|pfx|key)|credentials\.json)$'

status=0 file="" line=0
while IFS= read -r l; do
    case "$l" in
        "+++ b/"*) file="${l#+++ b/}"
            if printf '%s' "$file" | grep -qE "$BANNED_FILES"; then
                echo "  blocked file: $file (secrets live in files like this)" >&2; status=1
            fi ;;
        "+++ "*) ;;
        "@@ "*) line=$(printf '%s' "$l" | sed -E 's/^@@ -[0-9,]+ \+([0-9]+).*/\1/') ;;
        "+"*)
            if printf '%s' "${l#+}" | grep -qE "$PATTERN"; then
                echo "  credential-like text: $file:$line (value hidden)" >&2; status=1
            fi
            line=$((line + 1)) ;;
    esac
done
exit "$status"
