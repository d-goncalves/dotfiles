# PATH
ZSH_DIRECTORY="$HOME/.zsh"
HISTFILE="$HOME/.zsh/.zsh_history"  # change history file path
ZDOTDIR="$HOME/.zsh"

# Define machine enviroment variables
source $ZSH_DIRECTORY/environment.zsh

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim' # SSH remote editor
else
   export EDITOR='nvim' # Local editor
fi

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
bindkey '^v' edit-command-line
bindkey -v # for vi
KEYTIMEOUT=5 # Remove mode switching delay.

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

echo -ne '\e[5 q' # Use beam shape cursor on startup.

_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor) # Add fix cursor to precmd
bindkey jk vi-cmd-mode # Typing jk will get into vim mode

autoload -Uz compinit
compinit -d "$HOME/.zsh/.zcompdump" # change zcompdump file path
_comp_options+=(globdots)

# Add my custom script to current path
export PATH=$HOME/spells/bash/:$PATH

# Check if the machine if of work type
# For Linux load company related information
if [[ "$WORK" == "work" ]]; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        HELPER_SCRIPTS_PATH="$HOME/code/helperscripts"
        source $HELPER_SCRIPTS_PATH/docker_bash/.beevo_bash
    fi
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
