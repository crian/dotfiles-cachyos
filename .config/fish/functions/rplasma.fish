function rplasma --wraps='systemctl --user restart plasma-plasmashell.service' --description 'alias rplasma=systemctl --user restart plasma-plasmashell.service'
  systemctl --user restart plasma-plasmashell.service $argv
        
end
