alias ducks='du -hs * | gsort -hr'
alias cat='bat'
alias ss='ssh server'
alias pf="fzf --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"
alias gitlog="git log --oneline --decorate --color | fzf --ansi --preview 'git show $(echo {} | cut -d" " -f1)'"