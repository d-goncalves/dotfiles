#!/bin/sh

ZSH="$HOME/.zsh"
FZFPATH="$HOME/.zsh/fzf-tab"
AUTOCOMPLETE="$HOME/.zsh/zsh-autosuggestions"
GITPROMT="$HOME/.zsh/zsh-git-prompt"
SYNTAXHIGH="$HOME/.zsh/zsh-syntax-highlighting"
ALIASRC="$HOME/.zsh/aliasrc"

mkdir -p $ZSH
mkdir -p $FZFPATH && cd $ZSH && git clone https://github.com/Aloxaf/fzf-tab.git ~/.zsh/ || ( cd $FZFPATH && git pull )
mkdir -p $AUTOCOMPLETE && cd $ZSH && git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/ || ( cd $AUTOCOMPLETE && git pull )
mkdir -p $GITPROMT && cd $ZSH && git clone https://github.com/zsh-git-prompt/zsh-git-prompt.git ~/.zsh/ || ( cd $GITPROMT && git pull )
mkdir -p $SYNTAXHIGH && cd $ZSH && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/ || ( cd $SYNTAXHIGH && git pull )
# maybe zsh-vi-mode?
