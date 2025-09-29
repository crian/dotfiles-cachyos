function ahr
    # Define the AUR helper (e.g., paru, yay)
    set AURHELPER yay

    # List installed packages and allow selection with fzf
    set SELECTED_PKGS (eval $AURHELPER -Qsq | fzf --header="Remove packages" -m --preview "$AURHELPER -Si {}")

    # Check if any packages were selected
    if test -n "$SELECTED_PKGS"
        echo "Removing selected packages:"
        echo $SELECTED_PKGS | tr ' ' '\n'

        # Remove the selected packages
        eval $AURHELPER -Runs $SELECTED_PKGS
    else
        echo "No packages selected for removal."
    end
end
