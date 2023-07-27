#!/bin/bash
set -e # Exit script if any command fails

# List of packages to install
PACKAGES=(
    subversion
    python3-pip
    vim
    curl
    zsh
    apt-transport-https
    ca-certificates
    software-properties-common
)

# Update the package index and upgrade any existing packages
echo "Updating package index and upgrading existing packages. This might take a while..."
sudo apt update && sudo apt upgrade -y

# Install each package in the list
for package in "${PACKAGES[@]}"; do
    if dpkg -s "$package" >/dev/null 2>&1; then
        echo "$package is already installed."
    else
        echo "Installing $package..."
        sudo apt install -y "$package"
    fi
done

# Add Docker GPG key and repository
echo "Setting up Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update and install Docker packages
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add current user to the docker group
sudo usermod -aG docker $USER

# Install Docker Compose if not already installed
if ! [ -x "$(command -v docker-compose)" ]; then
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
else
    echo "Docker Compose is already installed."
fi

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
        echo "Installing $snap..."
        sudo snap install "$snap" --classic
    else
        echo "$snap is already installed."
    fi
done

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]
then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed."
fi

# Remind the user to reboot
echo "Script completed. Please reboot your system for changes to take effect."
