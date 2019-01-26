#!/usr/bin/env bash

# Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Auto Jump
git clone git://github.com/wting/autojump.git
cd autojump
./install.py

echo "logout to make shell changes permanent"
