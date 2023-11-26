#! /bin/bash

set -eu
set -o pipefail

#Update flatpak
/usr/bin/flatpak update -y

FLATPAKS=(
  ca.desrt.dconf-editor
  cc.arduino.IDE2
  com.belmoussaoui.Authenticator
  com.belmoussaoui.Obfuscate
  com.discordapp.Discord
  com.github.GradienceTeam.Gradience
  com.github.IsmaelMartinez.teams_for_linux
  com.github.alecaddd.sequeler
  com.github.finefindus.eyedropper
  com.github.marhkb.Pods
  com.github.muriloventuroso.pdftricks
  com.github.tchx84.Flatseal
  com.mattjakeman.ExtensionManager
  com.obsproject.Studio
  com.redis.RedisInsight
  io.beekeeperstudio.Studio
  io.freetubeapp.FreeTube
  io.github.Foldex.AdwSteamGtk
  io.github.celluloid_player.Celluloid
  io.github.giantpinkrobots.flatsweep
  io.github.realmazharhussain.GdmSettings
  io.github.shiftey.Desktop
  io.gitlab.adhami3310.Footage
  io.gitlab.zehkira.Monophony
  io.podman_desktop.PodmanDesktop
  md.obsidian.Obsidian
  org.cockpit_project.CockpitClient
  org.gimp.GIMP
  org.gnome.Boxes
  org.gnome.Calculator
  org.gnome.Calendar
  org.gnome.Characters
  org.gnome.Connections
  org.gnome.Contacts
  org.gnome.DejaDup
  org.gnome.Epiphany
  org.gnome.Evince
  org.gnome.Extensions
  org.gnome.Firmware
  org.gnome.Geary
  org.gnome.Logs
  org.gnome.NautilusPreviewer
  org.gnome.Shotwell
  org.gnome.Solanum
  org.gnome.SoundRecorder
  org.gnome.TextEditor
  org.gnome.Totem
  org.gnome.World.Secrets
  org.gnome.baobab
  org.gnome.clocks
  org.gnome.eog
  org.gnome.font-viewer
  org.gnome.meld
  org.kde.kdenlive
  org.kde.krita
  org.libreoffice.LibreOffice
  org.upscayl.Upscayl
  org.videolan.VLC
  page.codeberg.Imaginer.Imaginer
  rest.insomnia.Insomnia
)
#Update flatpak local repo
[ -d /data/flatpak-repo ] && flatpak create-usb /data/flatpak-repo "${FLATPAKS[@]}" --allow-partial
