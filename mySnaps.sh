#!/bin/bash

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
