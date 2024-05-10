# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
source $HOME/paths.shrc
source $HOME/aliases.shrc
source $HOME/functions.shrc

source $HOME/configs.shrc
source $HOME/end.shrc

export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# zsh-kubectl-prompt
autoload -U colors; colors

# zsh-gcloud-prompt
autoload -Uz colors; colors
skip_global_compinit=1
