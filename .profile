#
# .profile
#

# PATH
export PATH="$HOME/.local/bin:$PATH"

# XDG base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
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

# Micro colors
export MICRO_TRUECOLOR=1

# Electron wayland
export ELECTRON_OZONE_PLATFORM_HINT=auto

# fzf
export FZF_DEFAULT_COMMAND="fd -t f -L -H -c always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="\
    --ansi --border --height 100% \
    --preview 'bat --color=always {}' --preview-window :70% \
    "
