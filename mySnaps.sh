#!/bin/bash

sudo apt update
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# List of snaps to install
SNAPS=(
    dataspell
    webstorm
    code
    datagrip
    clion
    intellij-idea-ultimate
    pycharm-professional
    android-studio
    spotify
    docker
    discord
    postman
    remmina
    nmap
    bitwarden
    kata-containers
    google-cloud-sdk
    john-the-ripper
)

# Iterate over the list of snaps and install them
for snap in "${SNAPS[@]}"; do
    if ! snap list | grep -q "^$snap "; then
        sudo snap install "$snap" --classic
    else
        echo "$snap is already installed."
    fi
done

emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'