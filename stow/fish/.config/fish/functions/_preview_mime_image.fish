command --query viu || exit

set --local cmd (status basename | path change-extension "")

function $cmd
    #timg -g (math $COLUMNS - 2)x$LINES --frames 1 $argv
    if [ -n "$TERM_PROGRAM" ] && [ "$TERM_PROGRAM" = "WezTerm" ]
        timg -g (math $COLUMNS - 2)x$LINES -p k --frames 1 $argv
    else
        timg -g (math $COLUMNS - 2)x$LINES --frames 1 $argv
    end
end
