#
# ~/.bashrc
#

# Run fastfetch at startup (checks path dynamically)
if [[ $- == *i* ]] && command -v fastfetch &> /dev/null; then
    fastfetch
fi

# Enable bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#
# Shell options
#
shopt -s autocd         # change to named directory
shopt -s cdspell        # autocorrects cd misspellings
shopt -s cmdhist        # save multi-line commands in history as single line
shopt -s dotglob        # include hidden files
shopt -s histappend     # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize   # checks term size when bash regains control

#
# History Settings
#
export HISTFILESIZE=20000
export HISTSIZE=10000
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Append to history immediately, but read only new lines
# instead of reloading the full file
export PROMPT_COMMAND="history -a; history -n"

#
# Completion
#
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous On"

#
# Aliases
#

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias c="clear"
alias e="exit"

# Standard Utils Colors
alias grep="grep --color=auto"
alias diff="diff --color=auto"

# Safety
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -I"

# System / Arch Specific
alias df="df -h"
alias ff="fastfetch"
alias pac="sudo pacman --color=auto"
alias yu="yay -Syu --devel --timeupdate"
alias mirrors="sudo cachyos-rate-mirrors"
alias jctl="journalctl -p 3 -xb"
alias temp="watch sensors"
alias dots='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias wttr="curl -s wttr.in/Jülich"
alias sedit="sudoedit"
alias rplasma="systemctl --user restart plasma-plasmashell.service"

# LS / EZA Handling (Robustness check)
if command -v eza &> /dev/null; then
    alias ls="eza --color=always --group-directories-first --icons"
    alias la="eza -a --color=always --group-directories-first --icons"
    alias ll="eza -al --color=always --group-directories-first --icons"
    alias lt="eza --tree --level=2 --long --color=always --icons --git"
    alias l.="eza -a | grep -e '^\.'"
else
    # Fallback if eza is missing
    alias ls="ls --color=auto --group-directories-first"
    alias la="ls -a --color=auto --group-directories-first"
    alias ll="ls -al --color=auto --group-directories-first"
    alias l.="ls -a | grep -e '^\.'"
fi

#
# Functions
#

# Make dir and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# cd and ls into dir
cl() {
    local dir="$1"
    local dir="${dir:=$HOME}"
    if [[ -d "$dir" ]]; then
        cd "$dir" >/dev/null && ls
    else
        echo "cl: $dir: Directory not found"
    fi
}

# Fix Pacman Lock
fixpacman() {
    if pgrep -x pacman > /dev/null; then
        echo "Error: Pacman is running. Cannot remove lock file."
        return 1
    fi

    if [ -f /var/lib/pacman/db.lck ]; then
        local confirm
        read -p "Really remove lockfile? (y/N) " confirm
        if [[ "$confirm" =~ ^[yY]$ ]]; then
            sudo rm /var/lib/pacman/db.lck
            echo "Lock file removed."
        fi
    else
        echo "No lock file found."
    fi
}

# Cleanup System
cleanup() {
    echo "--- 1. Removing Orphans ---"
    # Check if orphans exist before trying to remove them to avoid errors
    if pacman -Qtdq > /dev/null 2>&1; then
        sudo pacman -Rns $(pacman -Qtdq)
    else
        echo "No orphaned packages found."
    fi

    if command -v paccache > /dev/null 2>&1; then
        echo "--- 2. Cleaning Pacman Cache ---"
        sudo paccache -r
    else
        echo "Tip: Install pacman-contrib for cache cleaning."
    fi
}

# Clear Plasma Cache
cplasma() {
    local confirm
    read -p "This will clear the Plasma Cache and requires a relogin. Continue? (y/N) " confirm

    if [[ "$confirm" =~ ^[yY]$ ]]; then
        local paths=(
            "$HOME/.cache/plasma"* "$HOME/.cache/qtshadercache"* "$HOME/.cache/systemsettings" "$HOME/.cache/thumbnails"
            "$HOME/.cache/event"* "$HOME/.cache/ks"*
        )

        for p in "${paths[@]}"; do
            if [ -e "$p" ]; then
                rm -rf "$p"
                echo "Deleted: $p"
            fi
        done
        echo "Cache cleared. Please restart your session."
    else
        echo "Aborted."
    fi
}

# Universal Extractor
extract() {
    if [ $# -eq 0 ]; then
        echo "Usage: extract <file>"
        return 1
    fi

    for n in "$@"; do
        if [ -f "$n" ]; then
            case "$n" in
                *.tar|*.tar.gz|*.tgz|*.tar.bz2|*.tbz2|*.tar.xz|*.txz|*.tar.zst|*.tzst)
                    tar xvf "$n" ;;
                *.7z)
                    7z x "$n" ;;
                *.zip)
                    unzip "$n" ;;
                *.rar)
                    unrar x "$n" ;;
                *.gz)
                    gunzip -k "$n" ;;
                *.bz2)
                    bunzip2 -k "$n" ;;
                *.xz)
                    unxz -k "$n" ;;
                *.zst)
                    zstd -d "$n" ;;
                *)
                    echo "Unknown format: $n" ;;
            esac
        else
            echo "File not found: $n"
        fi
    done
}

# Search and install packages (Yay + FZF)
yi() {
    local h="yay"
    local preview_cmd="$h -Si {1} | bat --style=plain --color=always"
    local selected

    selected=$($h -Slq | fzf --header="Install Packages ($h)" -m --preview "$preview_cmd")

    if [[ -n "$selected" ]]; then
        mapfile -t pkgs <<< "$selected"
        echo "Installing: ${pkgs[*]}"
        $h -S "${pkgs[@]}"
    else
        echo "Aborted."
    fi
}

# Search and remove packages (Yay + FZF)
yr() {
    local h="yay"
    local preview_cmd="$h -Qi {1} | bat --style=plain --color=always"
    local selected

    selected=$($h -Qsq | fzf --header="Remove Packages ($h)" -m --preview "$preview_cmd")

    if [[ -n "$selected" ]]; then
        mapfile -t pkgs <<< "$selected"
        echo "Removing: ${pkgs[*]}"
        $h -Runs "${pkgs[@]}"
    else
        echo "Aborted."
    fi
}

#
# Initialize Starship Prompt
#
eval "$(starship init bash)"
