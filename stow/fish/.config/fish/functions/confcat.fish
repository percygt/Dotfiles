    function confcat --description 'append a oneline command in .bashrc and config.fish'
        echo "$argv" >> $HOME/.bashrc
	echo "$argv" >> $HOME/.config/fish/config.fish
    end
