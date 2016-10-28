export ZSH=~/.oh-my-zsh

# ? tmux
# ? vi-mode
plugins=(git autojump last-working-dir)

ZSH_THEME=philips
HYPHEN_INSENSITIVE='true'
DISABLE_UNTRACKED_FILES_DIRTY="true"

export PATH='/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games'
export PATH=./node_modules/.bin:$PATH # BEM ENB


source $ZSH/oh-my-zsh.sh

alias e='vim'
alias st='subl'
alias upgrade='sudo apt-get update && sudo apt-get upgrade'
alias install='sudo apt-get install'
# Bower
alias bi='bower install'
alias bl='bower list'
alias bs='bower search'
# Better than grep
alias grep='ack -k'
# Where I am?
alias lll='pwd'
# ls aliases
alias LS='ls -lAcv --block-size=K'
alias lslast='ls -ltc'
# tmux
alias tmux='tmux attach || tmux new'
