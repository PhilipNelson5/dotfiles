#!/usr/bin/env bash

NC='\033[0m' # No Color
GREEN='\033[0;32m'

echo -e "${GREEN} Pulling master ${NC}"
cd ~/dotfiles
git pull origin master
sleep .1

echo -e "${GREEN} Unpacking dotfiles ${NC}"
cp ~/dotfiles/.Xresources ~/.Xresources
cp ~/dotfiles/.bash_aliases ~/.bash_aliases
cp ~/dotfiles/.clang-format ~/.clang-format
cp ~/dotfiles/.compton.conf ~/.conf/compton.conf
cp ~/dotfiles/.config_i3 ~/.i3/config
cp ~/dotfiles/.config_i3status ~/.config/i3status/config
cp ~/dotfiles/.config_termite ~/.config/termite/config
cp ~/dotfiles/.gitconfig ~/.gitconfig
cp ~/dotfiles/.tmux.conf ~/.tmux.conf
# cp ~/dotfiles/.vimrc ~/.vimrc
cp ~/dotfiles/.zshrc ~/.zshrc
sleep .1
echo -e "${GREEN} [DONE] ${NC}"

exit
