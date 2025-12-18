function yi --description "AUR Helper Install (yay)"
    set -l h yay

    set -l preview_cmd "$h -Si {1} | bat --style=plain"

    set -l pkgs ($h -Slq | fzf --header="Install Packages ($h)" -m --preview=$preview_cmd)

    if test -n "$pkgs"
        echo "Installing: $pkgs"
        $h -S $pkgs
    else
        echo "Aborted."
    end
end
