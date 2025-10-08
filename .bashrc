#
# ~/.bashrc
#

# Set fish as interactive shell
if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} && ${SHLVL} == 1 ]]
then
	shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
	exec fish $LOGIN_OPTION
fi

# Run fastfetch at startup
if [ -f /usr/bin/fastfetch ]; then
	fastfetch
fi

# Enable bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi


shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control


#
# History
#

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTTIMEFORMAT="%F %T" # add timestamp to history

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

#
# Completion
#

# Ignore case on auto-completion
bind "set completion-ignore-case on"

# Show auto-completion list automatically, without double tab
bind "set show-all-if-ambiguous On"

#
# aliases
#
alias ls="eza --color=always --group-directories-first --icons"
alias la="eza -a --color=always --group-directories-first --icons"
alias ll="eza -al --color=always --group-directories-first --icons"
alias lt="eza -aT --color=always --group-directories-first --icons"
alias l.="eza -a | grep -e '^\.'"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias cp="cp -i"
alias df="df -h"
alias c="clear"
alias ff="fastfetch"
alias pac="sudo pacman --color=auto"
alias yu="yay -Syu --devel --timeupdate"
alias mirrors="sudo cachyos-rate-mirrors"
alias jctl="journalctl -p 3 -xb"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias temp="watch sensors"
alias dots='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias wttr="curl -s wttr.in/Jülich"
alias e="exit"
alias sedit="sudoedit"
alias cplasma="rm -rf ~/.cache/plasma* && rm -rf ~/.cache/qtshadercache* && rm -rf ~/.cache/systemsettings && rm -rf ~/.cache/thumbnails && rm -rf ~/.cache/event* && rm -rf ~/.cache/ks*"
alias rplasma="systemctl --user restart plasma-plasmashell.service"

#
# functions
#

# Make dir and cd into it
mkcd() {
    mkdir -p "$1"
    cd "$1"
}

# cd and ls into dir
cl() {
	local dir="$1"
	local dir="${dir:=$HOME}"
	if [[ -d "$dir" ]]; then
		cd "$dir" >/dev/null; ls
	else
		echo "cl: $dir: Directory not found"
	fi
}

# Search and install packages with aur helper and fzf
ahi() {
    AURHELPER="paru"
    SELECTED_PKGS="$($AURHELPER -Slq | fzf --header='Install packages' -m --preview "$AURHELPER -Si {1}")"
    if [ -n "$SELECTED_PKGS" ]; then
        echo "Installing selected packages:"
        echo $SELECTED_PKGS | tr ' ' '\n'
        eval $AURHELPER -S $SELECTED_PKGS
    else
        echo "No packages selected."
    fi
}

# Search and remove packages with aur helper and fzf
ahr() {
    AURHELPER="paru"
    SELECTED_PKGS="$($AURHELPER -Qsq | fzf --header='Remove packages' -m --preview "$AURHELPER -Si {1}")"
    if [ -n "$SELECTED_PKGS" ]; then
        echo "Removing selected packages:"
        echo $SELECTED_PKGS | tr ' ' '\n'
        eval $AURHELPER -Runs $SELECTED_PKGS
    else
        echo "No packages selected."
    fi
}

#
# Prompt
#
eval "$(starship init bash)"
