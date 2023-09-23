# Define some useful aliases
alias ls='ls -la'
alias la='ls -a'
alias grep='grep --color=auto'
alias tmux='tmux -u'

# Set your preferred editor (e.g., Neovim)
export EDITOR=nvim

# Set your preferred Powerlevel10k theme
ZSH_THEME="powerlevel10k/powerlevel10k"
source /home/devuser/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
source /home/devuser/.p10k.zsh
# Enable zsh-syntax-highlighting
source /home/devuser/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable zsh-autosuggestions
source /home/devuser/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable zsh-completions
source /home/devuser/.oh-my-zsh/custom/plugins/zsh-completions/zsh-completions.plugin.zsh
