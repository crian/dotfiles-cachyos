function fixpacman --description "Remove pacman lock file safely"
    if pgrep -x pacman > /dev/null
        echo "Error: Pacman is running. Cannot remove lock file."
        return 1
    end

    if test -f /var/lib/pacman/db.lck
        read -P "Really remove lockfile? (y/N) " confirm
        if string match -qi "y" $confirm
            sudo rm /var/lib/pacman/db.lck
            echo "Lock file removed."
        end
    else
        echo "No lock file found."
    end
end
