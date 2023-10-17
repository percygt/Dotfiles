function funcadd --description "Add and save aliases"
	alias $argv
	funcsave $argv[1]
	set -l al 'alias '{$argv[1]}'='
	if grep -q $al ~/.bash_aliases
	    sed -i '/'{$al}'/d' ~/.bash_aliases
	    echo "alias $argv[1]='$argv[2]'" >> ~/.bash_aliases
	else
	    echo "alias $argv[1]='$argv[2]'" >> ~/.bash_aliases
	end
end
