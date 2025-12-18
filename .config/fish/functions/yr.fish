function yr --description "AUR Helper Remove (yay)"
    set -l h yay

    set -l preview_cmd "$h -Qi {1} | bat --style=plain"

    set -l pkgs ($h -Qsq | fzf --header="Remove Packages ($h)" -m --preview=$preview_cmd)

    if test -n "$pkgs"
        echo "Removing: $pkgs"
        $h -Runs $pkgs
    else
        echo "Aborted."
    end
end
