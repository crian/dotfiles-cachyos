function cleanup --description "Cleanup Orphans and Cache"
    echo "--- 1. Removing Orphans ---"
    set -l orphans (pacman -Qtdq 2>/dev/null)

    if test -n "$orphans"
        sudo pacman -Rns $orphans
    else
        echo "No orphaned packages found."
    end

    if type -q paccache
        echo "--- 2. Cleaning Pacman Cache ---"
        sudo paccache -r
    else
        echo "Tip: Install pacman-contrib for cache cleaning."
    end
end
