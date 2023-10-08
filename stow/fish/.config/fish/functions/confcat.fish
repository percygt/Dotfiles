    function confcat --description 'Append one line config in .bashrc and config.fish'
        set cf (status function)
        set -l options 'h/help'
        argparse -n funcdel $options -- $argv
        or return

        # should create a manpage
        if set -q _flag_help
            __fish_print_help cf
            return 0
        end

	if not set -q argv[1]
            printf (_ "%ls: Expected at least %d args, got only %d\n") $cf 1 0
            return 1
        end

	set -l retval 0
	echo "argv[1]" >> config.fish
        echo "argv[1]" >> .bashrc


	return $retval
    end
