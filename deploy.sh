#! /bin/sh

# Deploy dotfiles

if [ -e dotfiles.old ]
then
	echo "Old dotfiles.old found, abort!!"
	exit 1
fi

mkdir dotfiles.old

alias rm='mv -t dotfiles.old/'

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

# zsh
if [ -e ~/.zshrc ]
then
	echo ".zshrc already exists, skipping zsh setup"
else
	echo "Installing Oh-My-Zsh"
	pushd ~
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	popd
	cp custom.zsh-theme ~/.oh-my-zsh/themes/
	cp .zshrc ~/
	echo "zsh setup complete"
fi

echo "Done!"
echo "Run \`. ~/.bash_prompt' to load new bash prompt"
echo "Old dotfiles in dotfiles.old"
