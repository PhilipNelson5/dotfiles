#!/usr/bin/env bash

NC='\033[0m' # No Color
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'

echo -e "${GREEN} COPYING FILES"
echo -e "${CYAN}"

echo "BASH"
cp ~/.bashrc ./.bashrc
cp ~/.bash_aliases ./.bash_aliases
sleep .05

echo "CLANG FORMAT"
cp ~/.clang-format ./.clang-format
sleep .05

# echo "COMPTON"
# cp ~/.config/compton.conf ./config/compton.conf
# sleep .05

echo "GIT"
cp ~/.gitconfig ./.gitconfig
sleep .05

echo "i3"
cp ~/.i3/config ./.i3/config
sleep .05

echo "i3status"
cp ~/.config/i3status/config ./.config/i3status/config
sleep .05

echo "NEWS BOAT"
cp ~/.newsboat/config ./.newsboat/config
cp ~/.newsboat/urls ./.newsboat/urls

echo "TERMITE"
cp ~/.config/termite/config ./.config/neovim/config
sleep .05

echo "TMUX"
cp ~/.tmux.conf ./.tmux.conf
sleep .05

echo "VIM"
cp ~/.vim/config/* ./.vim/config
cp ~/.vim/colors/* ./.vim/colors
cp ~/.vim/snippits/* ./.vim/snippits
cp ~/.vim/syntax/* ./.vim/syntax
sleep .05

echo "URXVT"
cp ~/.Xresources ./.Xresources
cp ~/.urxvt/ext/* ./.urxvt/etc
sleep .05

echo "ZSH"
cp ~/.zshrc ./.zshrc
sleep .05

echo -e "${BLUE} Adding to git ${NC}"
git add .
sleep .1

echo -e "${BLUE} Committing to git ${NC}"
git commit

echo -e "${BLUE} Pushing to git ${NC}"
~/scripts/push.sh
sleep .1

echo -e "${GREEN} [DONE] ${NC}"
