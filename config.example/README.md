# Machine-specific configuration

These files are templates. `bootstrap.sh` copies `zsh` and `.gitconfig` to `~/code/config/` if they are not there.

Do not commit anything in `~/code/config/`. This repository is public.

The shell and git read three layers. Each layer overrides the layer before it:

1. **This repository:** generic settings.
2. **An optional work layer:** `~/work/config/work.zsh` and `~/work/config/work.gitconfig`. You keep these files separately. The git file applies only to repositories in `~/work`.
3. **This machine:** `~/code/config/zsh` and `~/code/config/.gitconfig`. Put these settings here: git identity, commit signing, tokens and aliases for this machine only.

After the first bootstrap on a new machine, change the name and email in `~/code/config/.gitconfig`. Do this before your first commit.
