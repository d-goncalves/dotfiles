# Machine-specific config

These are templates. `bootstrap.sh` copies `zsh` and `.gitconfig` to `~/code/config/` if they are missing, and nothing in `~/code/config/` is ever committed, because this repo is public.

Shell and git read three layers, each overriding the one before:

1. **This repo:** generic settings.
2. **An optional work layer:** `~/work/config/work.zsh` and `~/work/config/work.gitconfig`, maintained separately. The git file only applies to repositories under `~/work`.
3. **This machine:** `~/code/config/zsh` and `~/code/config/.gitconfig`. Git identity, commit signing, tokens, aliases for this machine only.

After the first bootstrap on a new machine, edit the name and email in `~/code/config/.gitconfig` before your first commit.
