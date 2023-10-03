    function funcdel --description 'Deletes a fish function both permanently and from memory'
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
        for funcname in $argv
            set -l funcfile $__fish_config_dir/functions/$funcname.fish

            # Delete the in-memory function, if it exists
            functions --query -- $funcname
            if test $status -eq 0
                functions --erase -- $funcname
                printf (_ "%s: function %s removed from session\n") $cf $funcname
            else
                printf (_ "%s: Unknown function '%s'\n") $cf $funcname
            end

            # Delete the function permanently,
            # if it exists as a file in the regular location
            if test -e $funcfile
                rm $funcfile
                printf (_ "%s: %s deleted\n") $cf $funcfile
            else
                printf (_ "%s: %s not found\n") $cf $funcfile
            end
        end

        return $retval
    end
