#!/usr/bin/env bash

if [ -e ~/.profile ]; then . ~/.profile; fi
if [[ -e ~/.aliases && $- = *i* ]]; then . ~/.aliases; fi
if [[ -e ~/.bashrc && $- = *i* ]]; then . ~/.bashrc; fi

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
  . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

test -f ~/.git-completion.bash && . $_

# Path to the bash it configuration
export BASH_IT="${HOME}/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
# export BASH_IT_THEME='bobby-python'
export BASH_IT_THEME='metal'
# export BASH_IT_THEME='modern'
# export BASH_IT_THEME='bira'
# export BASH_IT_THEME='barbuk'
# export BASH_IT_THEME='atomic'
# export BASH_IT_THEME='brainy'
# export BASH_IT_THEME='radek'
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
# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
# export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1


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
