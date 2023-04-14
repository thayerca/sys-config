#!/usr/bin/env zsh

# TODO: update this script
STOW_FOLDERS="git,kitty,nvim,tmux,vim,zsh"

DOT_FILES=$HOME/.dotfiles

pushd $DOT_FILES
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    stow -D $folder
    stow $folder
done
popd
