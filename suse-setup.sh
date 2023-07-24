#!/bin/bash

PACKAGES=(
    subversion
    python3-pip
    vim
    curl
    zsh
)

sudo zypper update -y

for package in "${PACKAGES[@]}"; do
    if rpm -q "$package" >/dev/null 2>&1; then
        echo "$package is already installed."
    else
        sudo zypper install -y "$package"
    fi
done

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo zypper addrepo https://download.docker.com/linux/opensuse/dockers-ce.repo

sudo zypper update && sudo zypper install -y docker-ce

sudo usermod -aG docker $USER

sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

docker --version

# Install Flatpak
sudo zypper install flatpak

# Add the Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

FLATPAKS=(
    com.spotify.Client
    com.discordapp.Discord
    com.getpostman.Postman
    org.remmina.Remmina
    com.jetbrains.PyCharm-Professional
    com.jetbrains.IntelliJ-IDEA-Ultimate
    com.jetbrains.CLion
    com.jetbrains.WebStorm
    com.jetbrains.DataGrip
    io.bitwarden.desktop
    com.google.AndroidStudio
)

for flatpak in "${FLATPAKS[@]}"; do
    if ! flatpak list | grep -q "$flatpak"; then
        flatpak install flathub "$flatpak" -y
    else
        echo "$flatpak is already installed."
    fi
done
