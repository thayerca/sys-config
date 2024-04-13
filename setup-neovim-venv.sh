#!/bin/bash

VENV_PATH="$HOME/.config/nvim/py3nvim"

echo "Creating Neovim Python 3 virtual environment in $VENV_PATH"
python3 -m venv $VENV_PATH
source $VENV_PATH/bin/activate
pip install pynvim
deactivate
echo "Virtual environment setup complete."

