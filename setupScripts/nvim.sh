#!/usr/bin/env bash

mkdir -p ~/.config/nvim/config
ln -sif $(pwd)/../.config/nvim/init.vim ~/.config/nvim/init.vim
ln -sif $(pwd)/../.config/nvim/config/general.vimrc ~/.config/nvim/config/general.vimrc
ln -sif $(pwd)/../.config/nvim/config/keys.vimrc ~/.config/nvim/config/keys.vimrc
ln -sif $(pwd)/../.config/nvim/config/plugins.vimrc ~/.config/nvim/config/plugins.vimrc
