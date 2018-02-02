#!/bin/bash

NC='\033[0m' # No Color
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'

echo -e "${GREEN} COPYING FILES"
echo -e "${CYAN}"

echo "BASH ALIASES"
cp ~/.bash_aliases ~/dotfiles/.bash_aliases
sleep .05

echo "CLANG FORMAT"
cp ~/.clang-format ~/dotfiles/.clang-format
sleep .05

echo "COMPTON"
cp ~/.config/compton.conf ~/dotfiles/.compton.conf
sleep .05

echo "GIT"
cp ~/.gitconfig ~/dotfiles/.gitconfig
sleep .05

echo "i3"
cp ~/.i3/config ~/dotfiles/.config_i3
sleep .05

echo "i3status"
cp ~/.config/i3status/config ~/dotfiles/.config_i3status
sleep .05

echo "TERMITE"
cp ~/.config/termite/config ~/dotfiles/.config_termite
sleep .05

echo "TMUX"
cp ~/.tmux.conf ~/dotfiles/.tmux.conf
sleep .05

echo "VIM"
cp ~/.vim/config/* ./.vim/config
cp ~/.vim/snippits/* ./.vim/snippits
cp ~/.vim/colors/* ./.vim/colors
sleep .05

echo "URXVT"
cp ~/.Xresources ~/dotfiles/.Xresources
sleep .05

echo "ZSH"
cp ~/.zshrc ~/dotfiles/.zshrc
sleep .05

cd ~/dotfiles

echo -e "${BLUE} Adding to git ${NC}"
sleep .1
git add .

echo -e "${BLUE} Committing to git ${NC}"
git commit

echo -e "${BLUE} Pushing to git ${NC}"
sleep .1
~/scripts/push.sh

echo -e "${GREEN} [DONE] ${NC}"
