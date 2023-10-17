function sethomeconf --description 'add link from configs and aliases to bashrc'
    set aliases (grep "#aliases" $HOME/.bashrc)
    set user_configs (grep "#user_configs" $HOME/.bashrc)

    not test -n "$aliases"; and echo -e "\n#aliases\n[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases" >> $HOME/.bashrc;
    not test -n "$user_configs"; and echo -e "\n#user_configs\n[ -f $HOME/.bash_configs ] && source $HOME/.bash_configs" >> $HOME/.bashrc
    test -n "$aliases"; and test -n "$user_configs"; and echo "You're good to go"; or echo "Something went wrong"
end
