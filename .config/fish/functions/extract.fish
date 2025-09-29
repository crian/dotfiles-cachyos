function extract
    set -l c
    set -l e 1

    # Check if arguments are provided
    if test (count $argv) -eq 0
        return 1
    end

    for i in $argv
        set c ''
        set e 1

        # Check if the file is readable
        if not test -r $i
            echo "$argv[0]: file is unreadable: '$i'" >&2
            continue
        end

        # Determine file type based on extension
        switch $i
            case '*.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz))))'
                set c "bsdtar xvf"
            case '*.7z'
                set c "7z x"
            case '*.Z'
                set c "uncompress"
            case '*.bz2'
                set c "bunzip2"
            case '*.exe'
                set c "cabextract"
            case '*.gz'
                set c "gunzip"
            case '*.rar'
                set c "unrar x"
            case '*.xz'
                set c "unxz"
            case '*.zip'
                set c "unzip"
            case '*'
                echo "$argv[0]: unrecognized file extension: '$i'" >&2
                continue
        end

        # Execute the corresponding extraction command
        eval $c $i
        set e (math "$e | $status")
    end

    return $e
end
