export TERM=xterm-256color

source ~/.zsh/zsh-git-prompt/zshrc.sh
# Enable colors and change prompt
autoload -U colors && colors	# Load colors
PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}%~%{$fg[red]%}]$(git_super_status)%{$fg[yellow]%}->'
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='nvim'
fi

# FZF
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
# source /usr/share/fzf/key-bindings.zsh
# source /usr/share/fzf/completion.zsh

# COMPANY: Beevo configs
HELPER_SCRIPTS_PATH="$HOME/Code/helperscripts"
source $HELPER_SCRIPTS_PATH/docker_bash/.beevo_bash

# source multiple plugins and alias
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.zsh/aliasrc

autoload -Uz compinit
compinit -d "$HOME/.zsh/.zcompdump"
HISTFILE="$HOME/.zsh/.zsh_history"
_comp_options+=(globdots)

# Still need to double check this
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
