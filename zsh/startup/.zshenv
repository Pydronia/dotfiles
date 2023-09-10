export FPATH=/usr/share/zsh/site-functions:/usr/share/zsh/5.5.1/functions:$FPATH
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
export ZDOTDIR="${ZDOTDIR:=$XDG_CONFIG_HOME/zsh}"
source "$ZDOTDIR/.zshenv"
