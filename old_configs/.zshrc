# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# poetry
export PATH="/Users/cthayer/.local/bin:$PATH"

# homebrew
export PATH="/usr/local/sbin:$PATH"
export EDITOR="vim"

# texlive
export PATH=/usr/local/texlive/2022basic/bin/universal-darwin:"${PATH}"

# google cloud
export CLOUDSDK_PYTHON=/Users/$USER/.pyenv/versions/zelus/bin/python3
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/application_default_credentials.json"
export VIRTUAL_ENV_DISABLE_PROMPT=true

# Setting language and localization variables
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ZSH_THEME=""
export ZSH="/Users/$USER/.oh-my-zsh"
ZSH_DISABLE_COMPFIX="true"

# Do not enable vi-mode or virtualenv plugis (incompatible with pure prompt)
plugins=(
    fzf
    ssh-agent
    git
    tmux
    kubectl
    poetry
    docker
    docker-compose
)
source $ZSH/oh-my-zsh.sh

# init apps
# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# direnv
eval "$(direnv hook zsh)"

# google cloud sdk
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

# aliases
alias ls='exa'
alias R='R --no-restore-data --no-save'
alias r="radian"
alias da='direnv allow'
alias dr='direnv reload'
alias gprunesquashmerged='git checkout -q master && \
    git for-each-ref refs/heads/ "--format=%(refname:short)" | \
    while read branch; \
    do mergeBase=$(git merge-base master $branch) && \
        [[ $(git cherry master \
        $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && \
        git branch -D $branch; done'
alias util='kubectl get nodes --no-headers | awk '\''{print $1}'\'' | xargs -I {} sh -c '\''echo {} ; kubectl describe node {} | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo '\'''
alias gotosleep="pmset sleepnow"
alias duckdb="/Applications/duckdb ; exit;"
alias glom="git pull origin main"

# zsh-completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
    autoload -Uz compinit
    compinit
fi

# zsh-auto-suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-syntax-highlight
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# kubectl
source <(kubectl completion zsh)

# add starship to prompt
eval "$(starship init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
iterm2_print_user_vars() {
  iterm2_set_user_var pyenv $((pyenv version 2> /dev/null) | cut -f 1 -d " ")
  iterm2_set_user_var kubectx $(kubectl config current-context 2> /dev/null)
  iterm2_set_user_var kubens $(kubectl config get-contexts | awk '/*/ {print $5}')
}
zdbb() {
    cd $HOME/zelus/basketball
    DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux` \
        && cd "$DIR"
}
zdg() {
  cd $HOME/zelus/general
  DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}
zdes() {
  cd $HOME/zelus/esports
  DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}
zdfb() {
  cd $HOME/zelus/football
  DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}
zgcp() {
  PROJECT=$(gcloud config configurations list --format json | jq -r ".[] | .name" | fzf-tmux)
  gcloud config configurations activate "$PROJECT"
}
dev-tag() {
  GIT_TIMESTAMP=$(date -u "+%Y%m%d.%H%M%S");
  if [[ $# -eq 1 ]] ; then
     echo "Tagging and pushing with dev-basketball-ct-$1-$GIT_TIMESTAMP"
     sleep 3
     git tag dev-basketball-ct-$1-$GIT_TIMESTAMP
     git push origin dev-basketball-ct-$1-$GIT_TIMESTAMP
  else
     echo "Error: requires exactly one argument"
  fi
}
glogone() {
    DEFAULT=10
    NUM_COMMITS="${1:-$DEFAULT}"
    git --no-pager log --oneline -n $NUM_COMMITS
}
killpods() {
    # app=bkrdp-ss, bkrdp-ngss, bkie
    # model=basketball-adjusted-plus-minus
    kubectl delete pods -l $1 
}
killjobs() {
    # app=bkrdp-ss, bkrdp-ngss, bkie
    # model=basketball-adjusted-plus-minus
    kubectl delete jobs -l $1
}
wpod() {
    watch -n $1 "kubectl get pod | grep $2"
}
wjob() {
    watch -n $1 "kubectl get job | grep $2"
}
zmvbbd() {
    kubectl port-forward svc/zelus-model-versioner -n zelus-model-versioner :80 | cloud_sql_proxy -instances=zelus-basketball-dev:us-central1:basketball-data=tcp:5432
}
dev-airflow() {
  if [[ $# -eq 1 ]] ; then
    echo "dev branch PR to $1"
    FEATURE_BRANCH=$(git branch --show-current);
    FEATURE_BRANCH_DEV=$(git branch --show-current)-dev;
    CURRENT_DIR=$PWD
    cd $(git rev-parse --show-toplevel)
    git branch --delete --force dev-$1;
    git branch --delete --force $FEATURE_BRANCH_DEV;
    git checkout dev-$1; git pull origin dev-$1;
    git checkout -b $FEATURE_BRANCH_DEV;
    git diff --name-only --diff-filter=AMR main $FEATURE_BRANCH | xargs git checkout $FEATURE_BRANCH --
    git diff --name-only --diff-filter=D dev-$1 $FEATURE_BRANCH | xargs git rm --
    git commit -m "$(git show -s --format=%s $FEATURE_BRANCH)"
    git push origin "$(git_current_branch)"
    git checkout $FEATURE_BRANCH
    cd $CURRENT_DIR
  else
     echo "Error: requires exactly one argument"
  fi
}
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export GPG_TTY=$(tty)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || bat -n --theme=base16 --color=always {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
