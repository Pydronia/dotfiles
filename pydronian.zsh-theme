export LSCOLORS=Gxfxcxdxbxegedabagacad
export LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

local ret_status="%(?:%F{yellow}❱ :%F{009}❱ )"

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    echo -n "%F{blue}%n%f@%F{green}%M%f:"
  fi
}

PROMPT='${ret_status}%f$(prompt_context)[%(!.%F{red}.%F{cyan})%3~%f]%f%{$reset_color%} '
RPROMPT='$(git_prompt_info)%'

ZSH_THEME_GIT_PROMPT_PREFIX="%Bgit:%F{blue}(%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{blue}) %F{red}𝗫"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{blue}) %F{green}✔"
