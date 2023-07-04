 installation failed." 
#!/bin/bash

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

sudo apt update && sudo apt upgrade -y

for package in "${PACKAGES[@]}"; do
    if dpkg -s "$package" >/dev/null 2>&1; then
        echo "$package is already installed."
    else
        sudo apt install -y "$package"
    fi
done

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker $USER

sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

docker --version

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

for snap in "${SNAPS[@]}"; do
    if ! snap list | grep -q "^$snap "; then
        sudo snap install "$snap" --classic
    else
        echo "$snap is already installed."
    fi
done

emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'
