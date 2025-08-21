#!/usr/bin/env bash

# Always load .bashrc (needed for cron's login, non-interactive shells)
[ -f ~/.bashrc ] && . ~/.bashrc

# Optional
[ -e ~/.profile ] && . ~/.profile
[ -e ~/.aliases ] && . ~/.aliases

# If not running interactively, stop here
case $- in *i*) ;; *) return ;; esac

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
  . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

test -f ~/.git-completion.bash && . $_

# Path to the bash it configuration
export BASH_IT="${HOME}/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# export BASH_IT_THEME='bobby-python'
export BASH_IT_THEME='metal'
export THEME_CLOCK_FORMAT="%H:%M"
export THEME_SHOW_PYTHON=true
export THEME_SHOW_BATTERY=true


# Don't check mail when opening terminal.
unset MAILCHECK


# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true
# Set to actual location of gitstatus directory if installed
export SCM_GIT_GITSTATUS_DIR="$HOME/gitstatus"
# per default gitstatus uses 2 times as many threads as CPU cores, you can change this here if you must
#export GITSTATUS_NUM_THREADS=8
export SCM_GIT_SHOW_STASH_INFO=false
export SCM_GIT_IGNORE_UNTRACKED=true
export SCM_GIT_SHOW_MINIMAL_INFO=false
export THEME_CHECK_SUDO=false


# Load Bash It
source "$BASH_IT"/bash_it.sh
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# uv
export PATH="/usr/local/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.bash 2>/dev/null || :
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"



