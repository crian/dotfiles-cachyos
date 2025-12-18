function extract --description "Archive extractor"
    if test (count $argv) -eq 0
        echo "Usage: extract <file>"
        return 1
    end

    for n in $argv
        if test -f $n
            switch $n
                case "*.tar" "*.tar.gz" "*.tgz" "*.tar.bz2" "*.tbz2" "*.tar.xz" "*.txz" "*.tar.zst" "*.tzst"
                    tar xvf $n
                case "*.7z"
                    7z x $n
                case "*.zip" "*.jar"
                    unzip $n
                case "*.rar"
                    unrar x $n
                case "*.gz"
                    gunzip -k $n
                case "*.bz2"
                    bunzip2 -k $n
                case "*.xz"
                    unxz -k $n
                case "*.zst"
                    zstd -d $n
                case "*"
                    echo "Unknown format: $n"
            end
        else
            echo "File not found: $n"
        end
    end
end
