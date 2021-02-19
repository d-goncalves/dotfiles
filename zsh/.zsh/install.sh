#!/bin/sh

ZSH="$HOME/.zsh"
FZFPATH="$HOME/.zsh/fzf-tab"
AUTOCOMPLETE="$HOME/.zsh/zsh-autosuggestions"
GITPROMT="$HOME/.zsh/zsh-git-prompt"
SYNTAXHIGH="$HOME/.zsh/zsh-syntax-highlighting"
ALIASRC="$HOME/.zsh/aliasrc"

cd $ZSH || ( mkdir -p $ZSH && cd $ZSH )
( cd $FZFPATH      && git pull ) || git clone https://github.com/Aloxaf/fzf-tab.git
( cd $AUTOCOMPLETE && git pull ) || git clone https://github.com/zsh-users/zsh-autosuggestions.git
( cd $GITPROMT     && git pull ) || git clone https://github.com/zsh-git-prompt/zsh-git-prompt.git
( cd $SYNTAXHIGH   && git pull ) || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
