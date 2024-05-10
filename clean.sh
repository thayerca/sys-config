#!/usr/bin/env zsh

### This script removes dotfile symlinks from $HOME

# available systems: mba-m2, zelus-m1
SYSTEM=$1
# cd into relevant dotfile folder
cd ~/dotfiles/$SYSTEM

# loop through folders and remove symlink
for dir in */;
do
    echo "Removing symlink for $dir"
    stow -D $dir --target=$HOME
done
