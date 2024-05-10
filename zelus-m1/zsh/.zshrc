# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/highlighters
plugins=(git macos docker docker-compose virtualenv vi-mode poetry)
# installed with brew therefor not in above list: zsh-syntax-highlighting zsh-autosuggestions

#this line should route all .zcompdump files into the cached dir
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

source $ZSH/oh-my-zsh.sh

# direnv
eval "$(direnv hook zsh)"
# kubectl
source <(kubectl completion zsh)
# google cloud sdk
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
iterm2_print_user_vars() {
  iterm2_set_user_var pyenv $((pyenv version 2> /dev/null) | cut -f 1 -d " ")
  iterm2_set_user_var kubectx $(kubectl config current-context 2> /dev/null)
  iterm2_set_user_var kubens $(kubectl config get-contexts | awk '/*/ {print $5}')
}
export GPG_TTY=$(tty)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || bat -n --theme=base16 --color=always {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# customized properties
source $HOME/aliases.shrc
source $HOME/functions.shrc

export SHELL=zsh

# fzf search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
# add pylsp path for python lsp support
export PATH="$PATH:/Users/cthayer/.pyenv/versions/3.8.12/envs/zelus/lib/python3.8/site-packages"

# add homebrew
export PATH=/opt/homebrew/bin:$PATH

# following https://earthly.dev/blog/homebrew-on-m1/
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# # openssl and new M1 chip
export PYTHON_BUILD_HOMEBREW_OPENSSL_FORMULA=openssl@3

# add this after homebrew to use m1 /opt/homebrew before old homebrew that was in /usr/local/bin 
export PATH="$PATH:/usr/local/bin/"

# zsh-kubectl-prompt
autoload -U colors; colors

# zsh-gcloud-prompt
autoload -Uz colors; colors
skip_global_compinit=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# autocompletion kubernetes
source <(kubectl completion zsh)

# needs to be on the end:
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

