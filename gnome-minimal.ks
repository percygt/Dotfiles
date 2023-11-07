url --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch"

# Use graphical install
graphical


# Install system packages
%packages
@fonts                                 # Fonts packages
@multimedia                            # Common audio/video frameworks
@networkmanager-submodules             # Common NetworkManager submodules
@printing                              # Tools to enable the system to print or act as a print server
fedora-workstation-repositories        # Default Fedora repositories
gnome-console
gnome-disk-utility
gnome-shell
gnome-system-monitor
gnome-tweaks
gnome-user-share
nautilus
file-roller
ostree
libappstream-glib
gnome-session-xsession
xdg-user-dirs
xdg-user-dirs-gtk
xdg-utils
xdg-desktop-portal-gnome
gvfs*
git
bash-completion
wget
unzip
micro
inotify-tools
firefox
make
flatpak
syncthing
stow
bzip2
tar
dnf-plugins-core
plymouth-system-theme
%end

%post
# Set the plymouth theme
plymouth-set-default-theme bgrt -R

# Change Systemd boot target
systemctl set-default graphical.target

systemctl enable gdm bluetooth NetworkManager

grub2-editenv - unset menu_auto_hide

# Configure Flatpak
systemctl disable flatpak-add-fedora-repos
flatpak remote-add flathub https://dl.flathub.org/repo/flathub.flatpakrepo

cat >> /etc/dnf/dnf.conf <<EOF
max_parallel_downloads=10
EOF

sed -i "s/#Experimental = false/Experimental = true/" /etc/bluetooth/main.conf

%end

# Reboot after installation
reboot --eject