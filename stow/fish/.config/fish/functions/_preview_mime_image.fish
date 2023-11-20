command --query viu || exit

set --local cmd (status basename | path change-extension "")

function $cmd
    timg -t (math $COLUMNS / 2),$LINES $argv
    #viu -h 20 $argv
end
