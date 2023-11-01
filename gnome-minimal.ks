url --mirrorlist="https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch"

# Use graphical install
graphical


# Install system packages
%packages
@base-x
#@fonts
#@multimedia                            # Common audio/video frameworks
fedora-workstation-repositories        # Default Fedora repositories
#gnome-console
#gnome-disk-utility
#gnome-shell
#gnome-system-monitor
#gnome-tweaks
#gnome-user-share
#nautilus
#file-roller
#gnome-session-xsession
#NetworkManager-wifi
#xdg-user-dirs
#xdg-user-dirs-gtk
#xdg-utils
#xdg-desktop-portal-gnome
gvfs*
git
#bash-completion
#wget
#unzip
micro
#inotify-tools
#firefox
make
#flatpak
#syncthing
#stow
#bzip2
dnf-plugins-core
#plymouth-system-theme
%end

%post
# Set the plymouth theme
#plymouth-set-default-theme bgrt -R

# Change Systemd boot target
#systemctl set-default graphical.target

#systemctl enable gdm bluetooth NetworkManager

grub2-editenv - unset menu_auto_hide

# Configure Flatpak
#systemctl disable flatpak-add-fedora-repos
#flatpak remote-add flathub https://dl.flathub.org/repo/flathub.flatpakrepo
#flatpak install -y flathub md.obsidian.Obsidian

#VSCode
cat > /etc/yum.repos.d/vscode.repo <<EOF
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

#Brave
cat > /etc/yum.repos.d/brave-browser.repo <<EOF
[code]
name=Brave Browser
baseurl=https://brave-browser-rpm-release.s3.brave.com/$basearch
enabled=1
gpgcheck=1
gpgkey=https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
EOF

#ProtonVPN
cat > /etc/yum.repos.d/protonvpn.repo <<EOF
[protonvpn-fedora-stable]
name = ProtonVPN Fedora Stable repository
baseurl = https://repo.protonvpn.com/fedora-$releasever-stable
enabled = 1
gpgcheck = 1
repo_gpgcheck=1
gpgkey = https://repo.protonvpn.com/fedora-$releasever-stable/public_key.asc

[protonvpn-fedora-unstable]
name = ProtonVPN Fedora Beta repository
baseurl = https://repo.protonvpn.com/fedora-$releasever-unstable
enabled = 1
gpgcheck = 1
repo_gpgcheck=1
gpgkey = https://repo.protonvpn.com/fedora-$releasever-unstable/public_key.asc
EOF

#Docker
dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

#fedora-cisco-openh264
dnf config-manager --set-enabled fedora-cisco-openh264

#COPR
dnf copr enable atim/starship
dnf copr enable lukenukem:asus-linux.repo
dnf copr enable atim:lazydocker.repo

#BTRFS
btrfs filesystem label / FEDORA

ROOT_UUID="$(grub2-probe --target=fs_uuid /)"
OPTIONS="$(grep '/home' /etc/fstab | awk '{print $4}' | cut -d, -f2-)"
SUBVOLUMES=(
    "opt"
    "var/cache"
    "var/crash"
    "var/log"
    "var/spool"
    "var/tmp"
    "var/www"
    "var/lib/AccountsService"
    "var/lib/gdm"
    "home/$USER/.mozilla"
    "home/$USER/.config/BraveSoftware"
)

for dir in "${SUBVOLUMES[@]}" ; do
    if [[ -d "/${dir}" ]] ; then
        mv -v "/${dir}" "/${dir}-old"
        btrfs subvolume create "/${dir}"
        cp -ar "/${dir}-old/." "/${dir}/"
    else
        btrfs subvolume create "/${dir}"
    fi
    restorecon -RF "/${dir}"
    printf "%-41s %-24s %-5s %-s %-s\n" \
        "UUID=${ROOT_UUID}" \
        "/${dir}" \
        "btrfs" \
        "subvol=${dir},${OPTIONS}" \
        "0 0" | \
        tee -a /etc/fstab
done

chmod 1777 /var/tmp
chmod 1770 /var/lib/gdm
chown -R $USER: /home/$USER/.mozilla
chown -R $USER: /home/$USER/.config/BraveSoftware

for dir in "${SUBVOLUMES[@]}" ; do
    if [[ -d "/${dir}-old" ]] ; then
        rm -rf "/${dir}-old"
    fi
done

%end

# Reboot after installation
reboot --eject