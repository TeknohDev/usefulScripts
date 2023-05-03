# My Package and Snap Installer Scripts

This repository contains two simple shell scripts for installing a predefined list of packages and snaps on a Ubuntu-based system. These scripts make it easy to set up a new system with all the required software quickly and efficiently.

## Usage

1. Clone this repository or download the two script files: `myPackages.sh` and `mySnaps.sh`.
2. Make sure the script files have executable permissions. If not, run the following commands:

```
chmod +x myPackages.sh
chmod +x mySnaps.sh
```

3. Execute the scripts one by one:

```
./myPackages.sh
./mySnaps.sh
```

## Scripts

### myPackages.sh

This script installs a list of packages using `apt`. Before installing the packages, it updates the package index and upgrades any existing packages.

The list of packages to be installed:

- subversion
- python3-pip
- vim
- curl

### mySnaps.sh

This script installs a list of snaps using `snap`. Before installing the snaps, it installs Zsh and Oh My Zsh.

The list of snaps to be installed:

- dataspell
- webstorm
- code
- datagrip
- clion
- intellij-idea-ultimate
- pycharm-professional
- android-studio
- spotify
- docker
- discord
- postman
- remmina
- nmap
- bitwarden
- kata-containers
- google-cloud-sdk
- john-the-ripper

## Notes

- The scripts have been tested on Ubuntu-based systems. They may not work as expected on other Linux distributions.
- Some snaps require a `--classic` flag for installation. The `mySnaps.sh` script installs all snaps with the `--classic` flag. If any snap doesn't require the `--classic` flag, you can edit the script accordingly.
- The scripts check if a package or snap is already installed before attempting to install it. If it's already installed, the script will skip it and display a message.

## License

This project is open-source and available under the MIT License. See the [LICENSE](LICENSE) file for more information.
