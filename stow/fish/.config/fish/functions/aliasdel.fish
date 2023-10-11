    function aliasdel --description 'Deletes a fish function both permanently and from memory'
        #deletes bash alias
        set -l al 'alias '{$argv[1]}
        echo $al
        sed '/'{$al}'/d' ~/.bash_aliases 

    end
