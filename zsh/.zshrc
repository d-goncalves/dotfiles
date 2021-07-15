# PATH
ZSH_DIRECTORY="$HOME/.zsh"
HISTFILE="$HOME/.zsh/.zsh_history"  # change history file path
ZDOTDIR="$HOME/.zsh"


if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim' # SSH remote editor
else
   export EDITOR='nvim' # Local editor
fi

# Configure completion
source $ZSH_DIRECTORY/completion.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

# Plugin sourcing
source $ZSH_DIRECTORY/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_DIRECTORY/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_DIRECTORY/fzf-tab/fzf-tab.plugin.zsh
source $ZSH_DIRECTORY/zsh-git-prompt/zshrc.sh

# General alias
source $ZSH_DIRECTORY/aliasrc

# Add my custom script to current path
export PATH=$HOME/scripts/:$PATH

# Colors and Prompt
export TERM=xterm-256color
autoload -U colors && colors	# Load colors
PROMPT='%B%{$fg[cyan]%}%~$(git_super_status)%{$fg[green]%} ❯ ' # Custom Prompt
setopt autocd		# Automatically cd into typed directory
stty stop undef		# Disable ctrl-s to freeze terminal

# General settings
CASE_SENSITIVE="true"                # case-sensitive completion
DISABLE_UPDATE_PROMPT="true"         # Automatically update without prompting.
DISABLE_AUTO_TITLE="true"            # Disable auto-setting terminal title.
ENABLE_CORRECTION="true"             # Enable command auto-correction.
COMPLETION_WAITING_DOTS="true"       # Display red dots whilst waiting for completion.
DISABLE_UNTRACKED_FILES_DIRTY="true" # Disable marking untracked files under VCS as dirty (Performance)

# Edit current line with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

autoload -Uz compinit
compinit -d "$HOME/.zsh/.zcompdump" # change zcompdump file path
_comp_options+=(globdots)

export PATH=$HOME/scripts/:$PATH # Add scripts to current path

# OS specific configuration
# On linux load Company related information
if [[ "$OSTYPE" == "linux-gnu"* ]]; then

    # COMPANY configuration only on linux
    HELPER_SCRIPTS_PATH="$HOME/code/helperscripts"
    source $HELPER_SCRIPTS_PATH/docker_bash/.beevo_bash
fi
