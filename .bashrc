source ~/scripts/env.sh
export LDFLAGS="-L/opt/homebrew/opt/openssl/lib"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$HOME/GowerSt/infrastructure/scripts:$PATH"
export PATH="/Users/michaeltsardakas/.local/bin:$PATH"
export PATH=$PATH:~/.docker/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/opt/homebrew/bin

# ---- minimal, safe for non-interactive ----
shopt -s expand_aliases
alias config='git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

dotfiles_autoupdate() {
  # Prefer avoiding alias to be extra-robust:
  git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" add -u && \
  git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" commit -m "Update $(date +"%Y-%m-%d %H:%M") $(uname -s)/$(uname -m)-$(hostname -s)" && \
  git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" push
}

dotfiles_init() {
  git --no-replace-objects clone --bare --depth 1 \
    git@github.com:mtsardakas/dotfiles.git "$HOME/.dotfiles"
  git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" config --local status.showUntrackedFiles no
  git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" checkout -f
}

# Return early for non-interactive AFTER the functions/aliases above:
[[ $- != *i* ]] && return

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"


rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=-1
export HISTSIZE=-1
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
export HISTCONTROL=erasedups
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"



# -- Use fd instead of fzf --
function frg {
  result=`rg --ignore-case --color=always --line-number --no-heading "$@" |
    fzf --ansi \
        --color 'hl:-1:underline,hl+:-1:underline:reverse' \
        --delimiter ':' \
        --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'`
  file="${result%%:*}"
  linenumber=`echo "${result}" | cut -d: -f2`
  if [ ! -z "$file" ]; then
          $EDITOR +"${linenumber}" "$file"
  fi
  }
  
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export FZF_DEFAULT_OPTS="--layout=reverse --border --info=inline --height=40%"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

eval "$(zoxide init bash)"


export PGSSLMODE=verify-ca
export PGSSLROOTCERT="$HOME/Downloads/global-bundle.pem"

eval "$(mise activate bash)"

mise_eval() {
    output=$(mise run $@)
    echo "Running: $output"
    eval "$output"
}



function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

export GPG_TTY=$(tty)

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
