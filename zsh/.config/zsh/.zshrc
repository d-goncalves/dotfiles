# Generic zsh config: works on macOS, Linux and WSL.
# Anything machine-specific (tokens, work aliases, internal hosts) goes in ~/work/config/zsh

# ── Options ───────────────────────────────────────────────────────────────────
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT   # `dir` cds, cd keeps a stack
setopt INTERACTIVE_COMMENTS NO_BEEP

# History lives outside the repo
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "${HISTFILE:h}"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

[[ -t 0 ]] && stty stop undef   # frees ctrl-s

# ── Environment ───────────────────────────────────────────────────────────────
typeset -U path PATH            # no duplicate entries, even in nested shells
path=("$HOME/.local/bin" $path)

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'  # SSH remote editor
else
    export EDITOR='nvim' # Local editor
fi
export VISUAL=$EDITOR
export MANPAGER='nvim +Man!'

# 1Password SSH agent, when it is set up on this machine
[[ -S $HOME/.1password/agent.sock ]] && export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

# fzf: list files with fd (fast, respects .gitignore) and preview directories
if command -v fd >/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# ── Aliases ───────────────────────────────────────────────────────────────────
alias e="$EDITOR" v="$EDITOR"
alias sv="sudo nvim" vim="nvim"
alias ..="cd .." ...="cd ../.." ....="cd ../../.." .....="cd ../../../.."
alias grep="grep --color=auto"

if command -v eza >/dev/null; then
    alias ls="eza --group-directories-first"
    alias l="eza -lah --group-directories-first --git" lsa="l"
    alias ll="eza -lh --group-directories-first --git"
    alias la="eza -lAh --group-directories-first --git"
    alias lt="eza --tree --level=2"
elif [[ $OSTYPE == darwin* ]]; then
    alias ls="ls -G"
    alias lsa="ls -lah" l="ls -lah" ll="ls -lh" la="ls -lAh"
else
    alias ls="ls -hN --color=auto --group-directories-first"
    alias diff="diff --color=auto"
    alias lsa="ls -lah" l="ls -lah" ll="ls -lh" la="ls -lAh"
fi

if command -v batcat >/dev/null; then alias cat=batcat      # Debian / Ubuntu name
elif command -v bat >/dev/null; then alias cat=bat; fi

# ── Completion ────────────────────────────────────────────────────────────────
# The dump is only rebuilt once a day; the rest of the time compinit skips its slow security scan
autoload -Uz compinit
() {
    setopt local_options extended_glob
    local dump="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/zcompdump"
    if [[ -n $dump(#qN.mh-24) ]]; then compinit -C -d "$dump"; else compinit -d "$dump"; fi
}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'          # ignore case
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no  # lets fzf-tab capture the unambiguous prefix
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# Tab / Shift-Tab walk through the candidates (wrapping around), Enter picks the highlighted one
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --cycle
zstyle ':fzf-tab:*' fzf-bindings 'tab:down' 'shift-tab:up'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

# ── Prompt ────────────────────────────────────────────────────────────────────
# One line: [~/path](branch|status) ->   Starship draws it (~/.config/starship.toml);
# without starship you get the same look minus the git part
if command -v starship >/dev/null; then
    eval "$(starship init zsh)"
else
    PROMPT='%B%F{red}[%F{yellow}%~%F{red}]%F{yellow} -> %b%f'
fi

# ── Tools ─────────────────────────────────────────────────────────────────────
command -v direnv >/dev/null && eval "$(direnv hook zsh)"
command -v jump >/dev/null && eval "$(jump shell zsh)"

# Machine-specific config (work tokens, internal aliases). Never part of this repo.
[[ -r $HOME/work/config/zsh ]] && source "$HOME/work/config/zsh"

# ── Plugins (installed by bootstrap.sh) ───────────────────────────────────────
plugin_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"

# Git aliases (gst, ga, gco, gl, gp, ...) from the oh-my-zsh git plugin
for p in ohmyzsh/lib/git.zsh ohmyzsh/plugins/git/git.plugin.zsh; do
    [[ -r $plugin_dir/$p ]] && source "$plugin_dir/$p"
done

ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# Everything that sets up keys or wraps widgets. fzf powers every completion (fzf-tab).
# Order matters: syntax-highlighting must come last.
_late_init() {
    command -v fzf >/dev/null && source <(fzf --zsh 2>/dev/null)
    local p
    for p in fzf-tab/fzf-tab.plugin.zsh \
             zsh-autosuggestions/zsh-autosuggestions.zsh \
             zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
        [[ -r $plugin_dir/$p ]] && source "$plugin_dir/$p"
    done
    # Edit the current command line in $EDITOR with ctrl-v
    autoload -Uz edit-command-line; zle -N edit-command-line
    bindkey '^v' edit-command-line
}
if [[ -r $plugin_dir/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]]; then
    # zsh-vi-mode resets keybindings on its first prompt, which would undo fzf-tab's Tab,
    # fzf's ctrl-r and ctrl-v, so all of that runs after it
    zvm_after_init() { _late_init }
    source "$plugin_dir/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
else
    _late_init
fi

# ── tmux ──────────────────────────────────────────────────────────────────────
# Start tmux in every terminal, reattaching to the running session when there is one.
# Skipped when already inside tmux, in IDE terminals, when there is no real terminal
# (scripts, tests), or with NO_TMUX=1 in the environment.
# exec makes leaving tmux close the terminal.
if command -v tmux >/dev/null && [[ -z $TMUX && -z $NO_TMUX && $TERM_PROGRAM != vscode && -t 0 && -t 1 ]]; then
    exec tmux new-session -A -s 0
fi
