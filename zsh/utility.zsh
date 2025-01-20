### SET GENERAL PROGRAM CONFIG AND ALIASES
# cd
alias -- -='cd -'
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# ls
export LSCOLORS='ExfxcxdxbxGxDxabagacad'
alias ls='ls -G'
alias ll='ls -lh'
alias l='ll -A'

# grep
alias grep='grep --color=auto'

# less
export LESS='-g -i -j.5 -M -R -S -w -X -z-4'
# colors
export LESS_TERMCAP_mb=$'\E[01;35m'       # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;35m'       # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'           # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'           # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;30;47m'    # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'           # Ends underline.
export LESS_TERMCAP_us=$'\E[01;34m'       # Begins underline.

