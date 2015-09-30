#! /bin/sh

# Deploy dotfiles

if [ -e ~/dotfiles_backup ]
then
	echo "Old ~/dotfiles_backup found, abort!!"
	exit 1
fi

mkdir ~/dotfiles_backup

alias rm='mv -t ~/dotfiles_backup/'

# Vim
echo "Deploying vim"

echo "Removing existing vim config"
rm ~/.vim
rm ~/.vimrc

echo "Deploying new vim config"
cp -r .vim ~/.vim
cp .vimrc ~/.vimrc

# tmux

echo "Deploying tmux"

echo "Removing existing tmux config"
rm ~/.tmux
rm ~/.tmux.conf

cp -r .tmux ~/.tmux
cp .tmux.conf ~/.tmux.conf

# Bash

if [ -e ~/.bash_prompt ]
then
	echo "Bash prompt already found, will not add source line to .bashrc"
else
	echo "source ~/.bash_prompt" >> ~/.bashrc
fi

rm ~/.bash_prompt
cp .bash_prompt ~/.bash_prompt

echo "Done!"
echo "Run \`. ~/.bash_prompt' to load new bash prompt"
echo "Old dotfiles in ~/dotfiles_backup"
