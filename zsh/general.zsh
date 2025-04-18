### SET CORE ZSH CONFIG

## zsh options
# Directories
setopt AUTO_CD # cd not required
setopt AUTO_PUSHD # automatically push dir to stack on CD
setopt PUSHD_IGNORE_DUPS # Ignore multiple copies of same directory
setopt PUSHD_SILENT # Don't print stack after pushd, popd
setopt PUSHD_TO_HOME # pushd = pushd ~

# Expansion
setopt EXTENDED_GLOB # Use zsh's extended globbing syntax
setopt GLOB_DOTS # Allow matching for files starting with "."

# History
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY

HISTFILE="${ZDOTDIR}/.zsh_data/.zsh_history"
HISTSIZE=20000
SAVEHIST=10000

# I/O
unsetopt CLOBBER
setopt INTERACTIVE_COMMENTS
setopt PATH_DIRS

# Jobs
setopt AUTO_RESUME
unsetopt BG_NICE
unsetopt CHECK_JOBS
unsetopt HUP
setopt LONG_LIST_JOBS

# Other
KEYTIMEOUT=5

## Setup run-help
unalias run-help 2>/dev/null
autoload -Uz run-help

## Editor, bindings
# vim mappings
bindkey -v

# Set key parameter (originally set in /etc/zshrc on mac)
typeset -g -A key
key=(
	F1         "${terminfo[kf1]}"
	F2         "${terminfo[kf2]}"
	F3         "${terminfo[kf3]}"
	F4         "${terminfo[kf4]}"
	F5         "${terminfo[kf5]}"
	F6         "${terminfo[kf6]}"
	F7         "${terminfo[kf7]}"
	F8         "${terminfo[kf8]}"
	F9         "${terminfo[kf9]}"
	F10        "${terminfo[kf10]}"
	F11        "${terminfo[kf11]}"
	F12        "${terminfo[kf12]}"
	Backspace  "${terminfo[kbs]}"
	Home       "${terminfo[khome]}"
	Insert     "${terminfo[kich1]}"
	Delete     "${terminfo[kdch1]}"
	End        "${terminfo[kend]}"
	PageDown   "${terminfo[knp]}"
	PageUp     "${terminfo[kpp]}"
	Up         "${terminfo[kcuu1]}"
	Down       "${terminfo[kcud1]}"
	Left       "${terminfo[kcub1]}"
	Right      "${terminfo[kcuf1]}"
	BackTab    "${terminfo[kcbt]}"
)

# Bind keys, based on zimfw input module
bindkey '\e[1;5D' vi-backward-word # ctrl+left
bindkey '\e[1;5C' vi-forward-word # ctrl+right
bindkey -M vicmd '\e[1;5D' vi-backward-word # ctrl+left
bindkey -M vicmd '\e[1;5C' vi-forward-word # ctrl+right

bindkey ${key[Backspace]} backward-delete-char
bindkey ${key[Delete]} delete-char
bindkey -M vicmd ${key[Delete]} delete-char # weird default func in cmd mode

bindkey ${key[Home]} beginning-of-line
bindkey ${key[End]} end-of-line

bindkey ${key[PageUp]} up-line-or-history
bindkey ${key[PageDown]} down-line-or-history

bindkey ${key[Insert]} overwrite-mode

bindkey ${key[BackTab]} reverse-menu-complete

# run-help
# This is using the code that ghostty sends for control-m (fixterms)
bindkey '\e[109;5u' run-help

# Magic space
bindkey ' ' magic-space

# Edit command line in EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Smart URL pasting/escaping
autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic

# Double dot expansion
double-dot-expand() {
	# Expand .. at the beginning, after space, or after any of ! " & ' / ; < > |
	if [[ ${LBUFFER} == (|*[[:space:]!\"\&\'/\;\<\>|]).. ]]; then
	  LBUFFER+=/..
	else
	  LBUFFER+=.
	fi
}
zle -N double-dot-expand
bindkey . double-dot-expand
bindkey -M isearch . self-insert

## hooks
autoload -Uz add-zle-hook-widget
autoload -Uz add-zsh-hook

# Shell features if not in Ghostty (already provides shell integration)
if [[ $TERM != *ghostty* ]]; then
	# Cursor shape adjustment
	set-cursor-style() {
		case ${KEYMAP-} in
			vicmd|visual) echo -ne "\e[1 q";;
			*) echo -ne "\e[5 q";;
		esac
	}
	zle -N set-cursor-style
	add-zle-hook-widget -Uz keymap-select set-cursor-style
	add-zle-hook-widget -Uz line-init set-cursor-style

	reset-cursor-style() {
		echo -ne "\e[0 q"
	}
	add-zsh-hook -Uz preexec reset-cursor-style

	# TODO: Emit OSC 133 codes
fi

# Set application mode ("keyboard-transit" mode?)
if [[ -n ${terminfo[smkx]} && -n ${terminfo[rmkx]} ]]; then
	# Enable application mode when zle is active
	start-application-mode() {
		echoti smkx
	}
	stop-application-mode() {
		echoti rmkx
	}
	add-zle-hook-widget -Uz line-init start-application-mode
	add-zle-hook-widget -Uz line-finish stop-application-mode
fi

