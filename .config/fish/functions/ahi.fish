function ahi
    # Define the AUR helper (e.g., paru, yay)
    set AURHELPER yay

    # Retrieve available packages and display with fzf for selection
    set SELECTED_PKGS (eval $AURHELPER -Slq | fzf --header="Install packages" -m --preview="$AURHELPER -Si {}")

    # Check if any packages were selected
    if test -n "$SELECTED_PKGS"
        echo "Installing selected packages:"
        echo $SELECTED_PKGS | tr ' ' '\n'

        # Install the selected packages
        eval $AURHELPER -S $SELECTED_PKGS
    else
        echo "No packages selected."
    end
end
