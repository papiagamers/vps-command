#!/bin/bash

set -e

# Showing The Banner of The VM:
show_banner() {
echo
echo "
██╗░░░██╗██████╗░░██████╗  ░█████╗░███╗░░░███╗██████╗░
██║░░░██║██╔══██╗██╔════╝  ██╔══██╗████╗░████║██╔══██╗
╚██╗░██╔╝██████╔╝╚█████╗░  ██║░░╚═╝██╔████╔██║██║░░██║
░╚████╔╝░██╔═══╝░░╚═══██╗  ██║░░██╗██║╚██╔╝██║██║░░██║
░░╚██╔╝░░██║░░░░░██████╔╝  ╚█████╔╝██║░╚═╝░██║██████╔╝
░░░╚═╝░░░╚═╝░░░░░╚═════╝░  ░╚════╝░╚═╝░░░░░╚═╝╚═════╝░"
echo
}

# Making The VM Main Menu Here:
main_menu() {
while true; do
clear
show_banner
echo
echo "1) Panel Installation"
  2) Wings Installation
  3) Panel Update
  5) Blueprint Setup
  6) Cloudflare Setup
  9) Tailscale (install + up)
 10) Database Setup
 11) Blueprints extensions Setup
  0) Exit
echo
read -p ["Choose In The From [1-6]: " choice

case $choice in

1)
echo "Insatalling The PteroDactyl Panel..."
sudo apt update && sudo apt upgrade -y & \
sudo apt install -y curl sudo & \
bash <(curl -s https://pterodactyl-installer.se)
echo "Done! Installed The Panel"
read
;;
2)
echo "Use The nano/etc To Start The Wing!"
read
;;
3)
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc && \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" && \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee && \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins
read
;;
4)
sudo apt update && \
curl -fsSL https://tailscale.com/install.sh | sh && \
sudo tailscale up
read
;;
5)
mkdir -p var/www/pterodactyl
export PTERODACTYL_DIRECTORY=/var/www/pterodactyl \
sudo apt install -y curl wget unzip \
cd $PTERODACTYL_DIRECTORY \
wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | grep 'release.zip' | cut -d '"' -f 4)" -O "$PTERODACTYL_DIRECTORY/release.zip"
unzip -o release.zip \
# Install dependencies
sudo apt install -y ca-certificates curl git gnupg unzip wget zip
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
sudo apt update
sudo apt install -y nodejs
cd $PTERODACTYL_DIRECTORY
npm i -g yarn
yarn install
# Creates a .blueprintrc file in your Pterodactyl directory
touch $PTERODACTYL_DIRECTORY/.blueprintrc
# Writes data to your .blueprintrc file
echo \
'WEBUSER="www-data";
OWNERSHIP="www-data:www-data";
USERSHELL="/bin/bash";' > $PTERODACTYL_DIRECTORY/.blueprintrc
# Give blueprint.sh execute permissions
chmod +x $PTERODACTYL_DIRECTORY/blueprint.sh

# Run blueprint.sh
bash $PTERODACTYL_DIRECTORY/blueprint.sh
read
;;
6)
echo
echo "
▒█░░▒█ ▒█▀▀█ ▒█▀▀▀█ 　 ▒█▀▀█ ▒█▀▀▀█ ▒█▀▄▀█ ▒█▀▄▀█ ░█▀▀█ ▒█▄░▒█ ▒█▀▀▄ ▒█▀▀▀█ █ 　 ▒█▀▀█ ▒█▀▀▀█ ▒█▀▀▀█ ▒█▀▀▄ ▒█▀▀█ ▒█░░▒█ ▒█▀▀▀ 
░▒█▒█░ ▒█▄▄█ ░▀▀▀▄▄ 　 ▒█░░░ ▒█░░▒█ ▒█▒█▒█ ▒█▒█▒█ ▒█▄▄█ ▒█▒█▒█ ▒█░▒█ ░▀▀▀▄▄ ▀ 　 ▒█░▄▄ ▒█░░▒█ ▒█░░▒█ ▒█░▒█ ▒█▀▀▄ ▒█▄▄▄█ ▒█▀▀▀ 
░░▀▄▀░ ▒█░░░ ▒█▄▄▄█ 　 ▒█▄▄█ ▒█▄▄▄█ ▒█░░▒█ ▒█░░▒█ ▒█░▒█ ▒█░░▀█ ▒█▄▄▀ ▒█▄▄▄█ ▄ 　 ▒█▄▄█ ▒█▄▄▄█ ▒█▄▄▄█ ▒█▄▄▀ ▒█▄▄█ ░░▒█░░ ▒█▄▄▄"
echo
echo "2025 VPS - COMMANDS TO USING THANKS!"
exit 0

*)
echo
echo "Invalid Choice! Choose From [1-6] Number"
esac
done
}

# End of The Panel:
main_menu
