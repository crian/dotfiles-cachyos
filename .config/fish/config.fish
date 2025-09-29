#
# config.fish
#

# Run fastfetch as welcome message
function fish_greeting
    fastfetch
end

# Run starship prompt
starship init fish | source
