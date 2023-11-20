if ! functions --query _preview_viewer_viu
    exit
end

function _preview_ext_jpg
    _preview_viewer_viu $argv
end
