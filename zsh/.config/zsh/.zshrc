# Generic zsh config: works on macOS, Linux and WSL.
# Anything machine-specific (tokens, work aliases, internal hosts) goes in ~/work/.zsh

# History lives outside the repo
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "${HISTFILE:h}"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'  # SSH remote editor
else
    export EDITOR='nvim' # Local editor
fi
export MANPAGER='nvim +Man!'
export PATH="$HOME/.local/bin:$PATH"

# 1Password SSH agent, when it is set up on this machine
[[ -S $HOME/.1password/agent.sock ]] && export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

[[ -t 0 ]] && stty stop undef

# Aliases
if [[ $OSTYPE == darwin* ]]; then
    alias ls="ls -G"
else
    alias ls="ls -hN --color=auto --group-directories-first"
    alias grep="grep --color=auto"
    alias diff="diff --color=auto"
fi
alias ccat="highlight --out-format=ansi"
alias e="$EDITOR" v="$EDITOR"
alias sv="sudo nvim" vim="nvim"
alias lsa="ls -lah" l="ls -lah" ll="ls -lh" la="ls -lAh"
alias ..="cd .." ...="cd ../.." ....="cd ../../.." .....="cd ../../../.." ......="cd ../../../../.." .......="cd ../../../../../.."
if command -v batcat >/dev/null; then alias cat=batcat      # Debian / Ubuntu name
elif command -v bat >/dev/null; then alias cat=bat; fi

# Prompt
autoload -U colors && colors
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%n%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
COMPLETION_WAITING_DOTS="true"       # Display red dots whilst waiting for completion.

# Edit the current command line in $EDITOR with ctrl-v
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# Completion
autoload -Uz compinit && compinit -d "${XDG_STATE_HOME:-$HOME/.local/state}/zsh/zcompdump"
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no  # lets fzf-tab capture the unambiguous prefix
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# Tool integrations, each only if installed
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
_fzf_init() { command -v fzf >/dev/null && source <(fzf --zsh 2>/dev/null) }
command -v direnv >/dev/null && eval "$(direnv hook zsh)"
command -v jump >/dev/null && eval "$(jump shell zsh)"

# Machine-specific config (work tokens, internal aliases). Never part of this repo.
[[ -r $HOME/work/.zsh ]] && source "$HOME/work/.zsh"

# Plugins, installed by bootstrap.sh. syntax-highlighting must stay last.
plugin_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
if [[ -r $plugin_dir/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]]; then
    zvm_after_init() { _fzf_init }   # zsh-vi-mode would otherwise overwrite fzf's keybindings
    source "$plugin_dir/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
else
    _fzf_init
fi
for p in fzf-tab/fzf-tab.plugin.zsh \
         zsh-autosuggestions/zsh-autosuggestions.zsh \
         zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
    [[ -r $plugin_dir/$p ]] && source "$plugin_dir/$p"
done
