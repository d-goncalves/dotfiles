ZSH_DIRECTORY="$HOME/.zsh"
HISTFILE="$HOME/.zsh/.zsh_history"  # change history file path
ZDOTDIR="$HOME/.zsh"

compinit -d "$HOME/.zsh/.zcompdump" # change zcompdump file path
autoload -Uz compinit

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'  # SSH remote editor
else
   export EDITOR='nvim' # Local editor
fi

autoload -U colors && colors                                   # Load colors
PROMPT='%B%{$fg[green]%}%~$(git_super_status)%{$fg[red]%} $ '  # Custom Prompt
stty stop undef                                                # Disable ctrl-s to freeze terminal

# General settings
DISABLE_UPDATE_PROMPT="true"         # Automatically update without prompting.
DISABLE_AUTO_TITLE="true"            # Disable auto-setting terminal title.
ENABLE_CORRECTION="true"             # Enable command auto-correction.
COMPLETION_WAITING_DOTS="true"       # Display red dots whilst waiting for completion.
DISABLE_UNTRACKED_FILES_DIRTY="true" # Disable marking untracked files under VCS as dirty (Performance)
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory
setopt histignoredups

autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

_fix_cursor() {
    echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor) # Add fix cursor to precmd
_comp_options+=(globdots)

# # Configure completion
source $ZSH_DIRECTORY/completion.zsh
source $ZSH_DIRECTORY/key-bindings.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

# Plugin sourcing
source $ZSH_DIRECTORY/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_DIRECTORY/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_DIRECTORY/fzf-tab/fzf-tab.plugin.zsh
source $ZSH_DIRECTORY/zsh-git-prompt/zshrc.sh

source $ZSH_DIRECTORY/aliasrc

export PATH=$HOME/.local/bin/:$PATH
if [ -e /home/diogo/.nix-profile/etc/profile.d/nix.sh ]; then . /home/diogo/.nix-profile/etc/profile.d/nix.sh; fi
