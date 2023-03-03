#!/bin/bash

# List of packages to install
PACKAGES=(
    subversion
    python3-pip
    package3
)

# Update the package index and upgrade any existing packages
sudo apt update
sudo apt upgrade -y

# Install each package in the list
for package in "${PACKAGES[@]}"; do
    if dpkg -s "$package" >/dev/null 2>&1; then
        echo "$package is already installed."
    else
        sudo apt install -y "$package"
    fi
done
