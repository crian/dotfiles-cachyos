#
# ~/.config/fish/config.fish
#

### Basic Settings & Environment

# Extend paths (for local binaries)
fish_add_path ~/.local/bin

# Set default editor (adapted for micro/nano)
if type -q micro
    set -gx EDITOR micro
    set -gx VISUAL micro
else
    set -gx EDITOR nano
end

# Manpage formatting (uses 'bat' if available)
if type -q bat
    set -x MANROFFOPT "-c"
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# Greeting (disabled or custom)
function fish_greeting
    if type -q fastfetch
        fastfetch
    else
        echo "Welcome to Fish Shell"
    end
end

### Interactive Settings

if status is-interactive

    # --- Integrations ---

    # Starship Prompt
    if type -q starship
        starship init fish | source
    end

    # Zoxide (Smarter 'cd' replacement)
    if type -q zoxide
        zoxide init fish --cmd cd | source
    end

    # FZF Keybindings (Ctrl+R, Ctrl+T)
    if type -q fzf
        fzf --fish | source
    end

    # --- Abbreviations (Expand when typing) ---

    # Standard
    abbr c clear
    abbr e exit
    abbr sedit sudoedit
    abbr ff fastfetch

    # Package Management
    abbr pac "sudo pacman"
    abbr par "paru"
    abbr y "yay"

    # System & Tools
    abbr df "df -h"
    abbr diff "diff --color=auto"
    abbr grep "grep --color=auto"
    abbr wget "wget -c"
    abbr ip "ip -c"
    abbr myip "curl http://ipecho.net/plain; echo"

    # Navigation
    abbr .. "cd .."
    abbr ... "cd ../.."

    # --- Aliases (Shortcuts & Safety) ---

    # Safety (Aliases are safer than abbr here, preventing accidental flag removal)
    alias cp="cp -i"
    alias mv="mv -i"
    alias rm="rm -I"

    # Eza (Modern 'ls' replacement) with FALLBACK
    if type -q eza
        alias ls="eza --color=always --group-directories-first --icons"
        alias ll="eza -al --color=always --group-directories-first --icons"
        alias la="eza -a --color=always --group-directories-first --icons"
        alias lt="eza --tree --level=2 --long --color=always --icons --git"
        alias l.="eza -a | grep -e '^\.'"
    else
        # Fallback if eza is missing
        alias ls="ls --color=auto --group-directories-first"
        alias ll="ls -al --color=auto --group-directories-first"
        alias l.="ls -a | grep -e '^\.'"
    end

    # System Maintenance Shortcuts
    alias yu="yay -Syu --devel --timeupdate"
    alias mirrors="sudo cachyos-rate-mirrors"
    alias jctl="journalctl -p 3 -xb"
    alias rplasma="systemctl --user restart plasma-plasmashell.service"
    alias dots="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

end
