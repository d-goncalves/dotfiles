#!/bin/sh

ZSH="~/.zsh"
FZFPATH="~/.zsh/fzf-tab"
AUTOCOMPLETE="~/.zsh/zsh-autosuggestions"
GITPROMT="~/.zsh/zsh-git-prompt"
SYNTAXHIGH="~/.zsh/zsh-syntax-highlighting"
ALIASRC="~/.zsh/aliasrc"
if [ ! -d ZSH ]
then
    echo "Creating .zsh directory"
    mkdir ZSH
fi

mkdir -p $ZSH
mkdir -p $FZFPATH && git clone https://github.com/Aloxaf/fzf-tab.git ~/.zsh/ || ( cd $FZFPATH && git pull )
mkdir -p $AUTOCOMPLETE && git clone https://github.com/Aloxaf/fzf-tab.git ~/.zsh/ || ( cd $AUTOCOMPLETE && git pull )
mkdir -p $GITPROMT && git clone https://github.com/Aloxaf/fzf-tab.git ~/.zsh/ || ( cd $GITPROMT && git pull )
mkdir -p $SYNTAXHIGH && git clone https://github.com/Aloxaf/fzf-tab.git ~/.zsh/ || ( cd $SYNTAXHIGH && git pull )
# Create directory for fzf tab
#if [ -d "~/.zsh/fzf-tab" ]
#then
#    cd ~/.zsh/fzf-tab
#    git pull
#else
#    git clone https://github.com/Aloxaf/fzf-tab.git ~/.zsh/
#fi

# Create directory for autosuggestions
#if [ -d "~/.zsh/zsh-autosuggestions" ]
#then
#    cd ~/.zsh/zsh-autosuggestions
#    git pull
#else
#    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/
#fi

# Create directory for zsh git promt
#if [ -d "~/.zsh/zsh-git-prompt" ]
#then
#    cd ~/.zsh/zsh-git-prompt
#    git pull
#else
#    git clone https://github.com/zsh-git-prompt/zsh-git-prompt.git ~/.zsh/
#fi

# Create directory for syntax highlighting
#if [ -d "~/.zsh/zsh-syntax-highlighting" ]
#then
#    cd ~/.zsh/zsh-syntax-highlighting
#    git pull
#else
#    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/
#fi
#
#if [ ! -e "~/.zsh/aliasrc"]
#    cp ./aliasrc ~/.zsh/aliasrc
