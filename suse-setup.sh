#!/bin/bash

# List of packages to install
PACKAGES=(
    subversion
    python3-pip
    vim
    curl
    apt-transport-https
    ca-certificates
    software-properties-common
)

# Update the package index and upgrade any existing packages
sudo apt update && sudo apt upgrade -y

# Install each package in the list
for package in "${PACKAGES[@]}"; do
    if dpkg -s "$package" >/dev/null 2>&1; then
        echo "$package is already installed."
    else
        sudo apt install -y "$package"
    fi
done

# Add Docker GPG key and repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update and install Docker packages
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add current user to the docker group
sudo usermod -aG docker $USER

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Check Docker version
docker --version

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

# Install zsh at the end
if ! dpkg -s "zsh" >/dev/null 2>&1; then
    sudo apt install -y zsh
else
    echo "zsh is already installed."
fi

# Install Oh My Zsh at the end
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
