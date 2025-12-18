#
# ~/.bash_profile
#

# PATH
export PATH="$HOME/.local/bin:$PATH"

# XDG base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Clean up Home
export HISTFILE="$XDG_STATE_HOME/bash/history"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export LESSHISTFILE=-

# EDITOR
export EDITOR="micro"
export VISUAL="$EDITOR"
export MICRO_TRUECOLOR=1

# Kwin / Electron Optimization
export KWIN_USE_OVERLAYS=1
export ELECTRON_OZONE_PLATFORM_HINT=auto

# PAGER & LESS
export PAGER="less"
export LESS='-g -i -M -R -S -w -z-4'
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_ue=$'\E[0m'

# fzf configuration
export FZF_DEFAULT_COMMAND="fd -t f -L -H -c always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="\
    --ansi --border --height 100% \
    --preview 'bat --color=always {}' --preview-window :70%"

#
# Source .bashrc if it exists
#
if [[ -f ~/.bashrc ]]; then
    . ~/.bashrc
fi
