function flatdel --wraps='=flatpak uninstall --delete-data' --wraps='flatpak uninstall --delete-data' --description 'alias flatdel flatpak uninstall --delete-data'
  flatpak uninstall --delete-data $argv
        
end
