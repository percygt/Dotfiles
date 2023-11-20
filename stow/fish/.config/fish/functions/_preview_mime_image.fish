command --query viu || exit

set --local cmd (status basename | path change-extension "")

function $cmd
    #timg -g (math $COLUMNS - 2)x$LINES --frames 1 $argv
    viu -h 20 $argv
end
