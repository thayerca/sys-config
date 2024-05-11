#!/usr/bin/env zsh

### This script sets up config symlinks in $HOME

# cd into relevant folder
cd ~/dotfiles/config

# loop through folders and symlink config files
for dir in */;
do
    echo "Stowing $dir"
    stow $dir --target=$HOME
    echo "Symlinked $dir folder to home directory"
done

# set up git config based on computer type
if [ "$1" != "personal" ] && [ "$1" != "zelus" ]; then
  echo "Invalid argument. Please specify 'personal' or 'zelus'"
  exit 1
fi

echo "Are you sure you want to symlink $1 git config to home directory? (y/n): "

read answer

if [ "$answer" != "y" ]; then
  echo "Aborted."
  exit 1
fi

# cd into relevant git config folder
cd ~/dotfiles/git-configs/

stow "$1" --target=$HOME
echo "Symlinked ~/dotfiles/git-configs/$1 folder to home directory"
