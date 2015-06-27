#
# ~/.bashrc
#

export EDITOR="vim"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls --color=auto -Flh'
alias open='xdg-open'
alias tmux='tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -s$USER@$HOSTNAME'
alias evince="evince $1 2>/dev/null"
alias mirage="mirage $1 2>/dev/null"
PS1='[\u@\h \W]\$ '

# Makes fonts darker and thicker
export INFINALITY_FT_BRIGHTNESS="-10"

# Not too sharp, not too smooth
export INFINALITY_FT_FILTER_PARAMS="16 20 28 20 16"

eval `dircolors ~/.dir_colors`

export PATH=~/.cabal/bin:$PATH
