#!/usr/bin/env zsh

### This script sets up dotfile symlinks in $HOME

# available systems: mba-m2, zelus-m1
SYSTEM=$1

# cd into relevant dotfile folder
cd ~/dotfiles/$SYSTEM

# loop through folders and stow
for dir in */;
do
    echo "Stowing $dir"
    stow $dir --target=$HOME
done
