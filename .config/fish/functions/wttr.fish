function wttr --wraps='curl -s wttr.in/Jülich' --description 'alias wttr=curl -s wttr.in/Jülich'
  curl -s wttr.in/Jülich $argv
end
