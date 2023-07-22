#!/bin/bash

# List of packages to install
PACKAGES=(
    subversion
    python3-pip
    vim
    curl
    zsh
    ca-certificates
    docker
    docker-compose
)

# Update the package index and upgrade any existing packages
sudo zypper ref && sudo zypper up -y

# Install each package in the list
for package in "${PACKAGES[@]}"; do
    if zypper se -i "$package" >/dev/null 2>&1; then
        echo "$package is already installed."
    else
        sudo zypper in -y "$package"
    fi
done

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Add Docker repository
sudo zypper ar https://download.opensuse.org/repositories/Virtualization:containers/openSUSE_Leap_15.2/Virtualization:containers.repo

# Install Docker packages
sudo zypper in -y docker docker-compose

# Enable Docker service
sudo systemctl enable docker

# Add current user to the docker group
sudo usermod -aG docker $USER

# Check Docker version
docker --version

# List of snaps to install (OpenSUSE uses Flatpaks instead of Snaps, but not all apps are available as Flatpaks.)
FLATPAKS=(
    com.jetbrains.DataSpell
    com.jetbrains.WebStorm
    com.visualstudio.code
    com.jetbrains.DataGrip
    com.jetbrains.CLion
    com.jetbrains.IntelliJ-IDEA-Ultimate
    com.jetbrains.PyCharm-Professional
    com.google.AndroidStudio
    com.spotify.Client
    com.discordapp.Discord
    com.getpostman.Postman
    org.remmina.Remmina
    io.github.bitwarden.desktop
    org.gnome.Epiphany # (no Google Cloud SDK Flatpak available)
)

# Add flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Iterate over the list of flatpaks and install them
for flatpak in "${FLATPAKS[@]}"; do
    if ! flatpak list | grep -q "$flatpak"; then
        flatpak install flathub "$flatpak" -y
    else
        echo "$flatpak is already installed."
    fi
done
