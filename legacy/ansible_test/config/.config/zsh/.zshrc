# _fix_cursor() {
#     echo -ne '\e[5 q'
# }
# precmd_functions+=(_fix_cursor) # Add fix cursor to precmd

ZSH_DIRECTORY="$HOME/.config/zsh"
HISTFILE="$ZSH_DIRECTORY/.zsh_history"  # change history file path
ZDOTDIR="$ZSH_DIRECTORY"


if [[ "$OSTYPE" == "darwin"* ]];then
    alias \
        ls="ls -G" \
        grep="grep" \
        diff="diff" \
        ccat="highlight --out-format=ansi"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias \
        ls="ls -hN --color=auto --group-directories-first" \
        grep="grep --color=auto" \
        diff="diff --color=auto" \
        ccat="highlight --out-format=ansi"
fi

alias \
	f="$FILE" \
	e="$EDITOR" \
	v="$EDITOR"


# Common alias! abbreviate them
alias \
    sv="sudo nvim" \
    vim="nvim" \

# List directory contents
alias \
    lsa="ls -lah" \
    l="ls -lah" \
    ll="ls -lh" \
    la="ls -lAh"

# change directory backwards
alias \
    ..="cd .." \
    ...="cd ../.." \
    ....="cd ../../.." \
    .....="cd ../../../.." \
    ......="cd ../../../../.." \
    .......="cd ../../../../../.."

alias cat=batcat
alias with-cachix-key="vaultenv --secrets-file <(echo "cachix#signing-key") -- "
alias gssh="gcloud compute ssh --tunnel-through-iap"

function which-hosts() {
}

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'  # SSH remote editor
else
   export EDITOR='nvim' # Local editor
fi

stty stop undef
autoload -U colors && colors                                   # Load colors
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%n%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
# PROMPT='%B%{$fg[green]%}%~%{$fg[red]%} $ '  # Custom Prompt
COMPLETION_WAITING_DOTS="true"       # Display red dots whilst waiting for completion.

autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

PATH=~/.local/bin:$PATH

# hacky was of get pylint to detect extensions
# export PYTHONPATH=$PYTHONPATH:.

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

SSH_AUTH_SOCK=~/.1password/agent.sock
MANPAGER='nvim +Man!'



# source $HOME/.atuin/bin/env
