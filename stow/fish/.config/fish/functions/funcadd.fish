function funcadd --description "Add and save aliases"
	alias $argv
	funcsave $argv[1]
	echo "alias $argv[1]='$argv[2]'" >> $HOME/.bash_aliases
	
end
