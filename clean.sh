#!/usr/bin/env zsh

### This script removes config symlinks from $HOME

# cd into relevant folder
cd ~/dotfiles/mba-m2/

# loop through folders and remove symlink
for dir in */;
do
    echo "Removing symlink for $dir"
    stow -D $dir --target=$HOME
    echo "Done"
done

# set up git config based on computer type
if [ "$1" != "personal" ] && [ "$1" != "zelus" ]; then
  echo "Invalid argument. Please specify 'personal' or 'zelus'"
  exit 1
fi

# cd into relevant git config folder
cd ~/dotfiles/

echo "Removing symlink for /git-configs/$1"
stow -D "/git-configs/$1" --target=$HOME
echo "Done"
