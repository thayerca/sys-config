#!/usr/bin/env bash

# Exit immediately if any command fails
set -e

### Install Homebrew if not already installed
if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed."
fi

### Install all packages from Brewfile
echo "Installing packages from Brewfile..."
brew bundle --file=~/sys-config/Brewfile

### Symlink Config Files
echo "Creating symlinks for configuration files..."
ln -sf ~/sys-config/zsh/.zshrc ~/.zshrc
ln -sf ~/sys-config/zsh/.zprofile ~/.zprofile
ln -sf ~/sys-config/zsh/aliases.shrc ~/.aliases.shrc
ln -sf ~/sys-config/zsh/functions.shrc ~/.functions.shrc
ln -sf ~/sys-config/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/sys-config/tmux/.tmux ~/.tmux
ln -sf ~/sys-config/powerline/.p10k.zsh ~/.p10k.zsh
ln -sf ~/sys-config/fzf/ ~/.fzf
ln -sf ~/sys-config/git-configs/.gitconfig ~/.gitconfig
ln -sf ~/sys-config/git-configs/.gitignore_global ~/.gitignore_global
ln -sf ~/sys-config/nvim/ ~/.config/nvim
ln -sf ~/sys-config/kitty ~/.config/kitty

### Install fonts for powerline
if [ ! -d "$HOME/fonts" ]; then
    echo "Installing Powerline fonts..."
    git clone https://github.com/powerline/fonts.git --depth=1 ~/fonts
    ~/fonts/install.sh
    rm -rf ~/fonts
fi

### Install oh my zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
### Install fzf shell integration
echo "Setting up fzf shell integration..."
$(brew --prefix)/opt/fzf/install --all

### Set up tpm
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

### Setup pyenv with Python 3.11
if ! command -v pyenv &> /dev/null; then
    echo "Installing pyenv..."
    curl https://pyenv.run | bash
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    echo "Installing Python 3.11..."
    pyenv install 3.11.0
    pyenv global 3.11.0
fi

echo "Setup complete!"
