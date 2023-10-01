function chsh
	set cmd $argv            
	set url "https://cheat.sh/$cmd"
	curl -s $url && echo
end
