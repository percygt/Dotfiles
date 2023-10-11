    function aliasdel --description 'Deletes a fish function both permanently and from memory'
        #deletes bash alias
        sed ' "$argv[1]" d' ~/.bash_aliases 

    end
