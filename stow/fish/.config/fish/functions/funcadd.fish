function funcadd --description "Add and save aliases"
	set cf (status function)
        set -l options 'h/help'
        argparse -n funcadd $options -- $argv
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

	alias $argv
	funcsave $argv[1]
	echo "alias $argv[1]='$argv[2]'" >> $HOME/.bashrc_aliases
	
end
