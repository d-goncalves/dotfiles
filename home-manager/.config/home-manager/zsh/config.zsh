# _fix_cursor() {
#     echo -ne '\e[5 q'
# }
# precmd_functions+=(_fix_cursor) # Add fix cursor to precmd

if [[ "$OSTYPE" == "darwin"* ]];then
    alias \
        ls="ls -G" \
        grep="grep" \
        diff="diff" \
        ccat="highlight --out-format=ansi"
# Linux specific configuration ( TESTED ON UBUNTU )
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
    vi="vim" \
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

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'  # SSH remote editor
else
   export EDITOR='nvim' # Local editor
fi

stty stop undef
autoload -U colors && colors                                   # Load colors
setopt PROMPT_SUBST
PROMPT='%B%{$fg[green]%}%~$(git_super_status)%{$fg[red]%} $ '  # Custom Prompt
COMPLETION_WAITING_DOTS="true"       # Display red dots whilst waiting for completion.

autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

PATH=~/.local/bin:$PATH

# hacky was of get pylint to detect extensions
export PYTHONPATH=$PYTHONPATH:.

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# Temporary fix until new version of FZF is released
# This is broken on version 0.46.1 of FZF
export FZF_TMUX_OPTS='-p 100%,40% -y P'
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
