function cplasma --description "Clear KDE Plasma Cache"
    read -P "This will clear the Plasma Cache and requires a relogin. Continue? (y/N) " confirm

    if string match -qi "y" $confirm
        set -l paths ~/.cache/plasma* ~/.cache/qtshadercache* ~/.cache/systemsettings ~/.cache/thumbnails ~/.cache/event* ~/.cache/ks*

        for p in $paths
            if test -e $p
                rm -rf $p
                echo "Deleted: $p"
            end
        end
        echo "Cache cleared. Please restart your session."
    else
        echo "Aborted."
    end
end
