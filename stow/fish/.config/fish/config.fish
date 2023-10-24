if status is-interactive
	starship init fish | source
 # Commands to run in interactive sessions can go here
end

set -l count (ps a | awk '{print $2}' | grep -vi "tty*" | uniq | wc -l);
if test $count -le 3
     neofetch
end

pyenv init - | source
