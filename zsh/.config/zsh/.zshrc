# zsh config for macOS, Linux and WSL, built on oh-my-zsh (installed by bootstrap.sh).
# Layers, in the order they load:
#   1. this file (generic)
#   2. ~/work/config/work.zsh   optional work layer, maintained separately; before oh-my-zsh so it can set env
#   3. ~/code/config/zsh        this machine only (tokens, aliases); last, so it wins. Never in this repo.

export ZSH="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh"
typeset -U path PATH            # no duplicate entries, even in nested shells

# ── Environment ───────────────────────────────────────────────────────────────
if [[ "$(uname -s)" == Darwin ]]; then
    export LANG="${LANG:-en_US.UTF-8}"
else
    export LANG=C.UTF-8
fi
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export LESS='-FRXi'
export MANPAGER='nvim +Man!'
[[ -t 0 ]] && export GPG_TTY="$(tty)"
[[ -t 0 ]] && stty stop undef   # frees ctrl-s
[[ -n "${WSL_DISTRO_NAME:-}" ]] && export BROWSER=wsl-browser
path=("$HOME/.local/bin" $path)

[[ -r "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -r "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# 1Password SSH agent, only when its socket exists: the Linux/WSL path, or the macOS app's own.
# A machine without 1Password (a work PC, say) skips this and keeps its normal ssh-agent.
for sock in "$HOME/.1password/agent.sock" "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"; do
    if [[ -S $sock ]]; then export SSH_AUTH_SOCK="$sock"; break; fi
done
unset sock

# Homebrew: macOS (Apple Silicon / Intel) or Linuxbrew on Linux and WSL
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
elif (( $+commands[brew] )); then
    eval "$(brew shellenv)"
fi
if (( $+commands[brew] )); then
    rustup_bin="$(brew --prefix)/opt/rustup/bin"
    [[ -d "$rustup_bin" ]] && path=("$rustup_bin" $path)
    unset rustup_bin
fi

# fzf: list files with fd (fast, respects .gitignore) and preview directories
if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# ── History: lives outside the repo (~/.config/zsh can be a symlink into it) ──
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "${HISTFILE:h}"
HISTSIZE=50000
SAVEHIST=50000
ZSH_COMPDUMP="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/zcompdump-$ZSH_VERSION"

# ── oh-my-zsh ─────────────────────────────────────────────────────────────────
ZSH_THEME="robbyrussell"    # only a fallback: starship draws the prompt below
HYPHEN_INSENSITIVE="true"
zstyle ':omz:update' mode reminder
# Start tmux in every real terminal. Skipped in IDE terminals, scripts, or with NO_TMUX=1.
ZSH_TMUX_AUTOSTART=false
[[ -o interactive && -t 0 && -t 1 && -z $NO_TMUX && $TERM_PROGRAM != vscode ]] && ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false
ZSH_TMUX_FIXTERM=false
plugins=(git colored-man-pages colorize common-aliases command-not-found docker-compose docker fzf tmux zsh-completions fzf-tab zsh-autosuggestions zsh-syntax-highlighting)

# Optional work layer (see top of file)
[[ -r ~/work/config/work.zsh ]] && source ~/work/config/work.zsh

if [[ -r $ZSH/oh-my-zsh.sh ]]; then
    source $ZSH/oh-my-zsh.sh
else
    echo "oh-my-zsh is missing: run ./bootstrap.sh from the dotfiles repo" >&2
fi
(( $+functions[_tars] )) && compdef _tars tars

if (( $+commands[starship] )); then
    export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"   # starship's default is ~/.config/starship.toml
    eval "$(starship init zsh)"
fi
(( $+commands[zoxide] )) && eval "$(zoxide init zsh --cmd j)"
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

# ── Options ───────────────────────────────────────────────────────────────────
setopt SHARE_HISTORY EXTENDED_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_VERIFY
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT INTERACTIVE_COMMENTS NO_BEEP

# ── Completion ────────────────────────────────────────────────────────────────
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'          # ignore case
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
zstyle ':completion:*' menu no  # lets fzf-tab capture the unambiguous prefix
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# Tab / Shift-Tab walk through the candidates (wrapping around), Enter picks the highlighted one
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --cycle
zstyle ':fzf-tab:*' fzf-bindings 'tab:down' 'shift-tab:up'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

# Edit the current command line in $EDITOR with ctrl-v
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# ── Aliases ───────────────────────────────────────────────────────────────────
if (( $+commands[eza] )); then
    alias ls='eza --icons=auto --group-directories-first'
    alias ll='eza -lh --git --icons=auto --group-directories-first'
    alias la='eza -lAh --git --icons=auto --group-directories-first'
    alias l='eza -lah --git --icons=auto --group-directories-first'
    alias lsa='eza -lah --git --icons=auto --group-directories-first'
    alias lt='eza --tree --level=2 --icons=auto'
else
    alias ll='ls -lh'
    alias la='ls -lAh'
    alias l='ls -CFlah'
fi
if (( $+commands[bat] )); then alias cat='bat --paging=never'
elif (( $+commands[batcat] )); then alias cat='batcat --paging=never'; fi   # Debian / Ubuntu name
(( $+commands[lazygit] )) && alias lg='lazygit'
(( $+commands[btop] )) && alias top='btop'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."

unalias 'H' 'T' 'G' 'L' 'M' 'LL' 'CA' 'NE' 'NUL' 'P' 'HL' 'TL' 'S' 'B' 2>/dev/null

alias e="$EDITOR" v="$EDITOR" sv="sudo nvim"
alias vim=nvim
alias gst='git status'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Machine-specific config (tokens, aliases for this machine only). Never part of this repo.
[[ -r $HOME/code/config/zsh ]] && source "$HOME/code/config/zsh"
