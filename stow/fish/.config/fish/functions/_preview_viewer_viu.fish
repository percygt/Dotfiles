set --local cmd (status basename | path change-extension "")

function $cmd
    viu -b -h 20 $argv
end
