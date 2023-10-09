#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Update the system
echo "Updating system..."
apt-get update && apt-get upgrade -y

# Install required packages
echo "Installing zip and unzip..."
apt-get install -y zip unzip

# Download Gophish
echo "Downloading Gophish..."
wget "https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip" -O gophish-v0.12.1-linux-64bit.zip

# Unzip Gophish
echo "Unzipping Gophish..."
unzip gophish-v0.12.1-linux-64bit.zip 

# Generate SSL certificates
echo "Generating SSL certificates for Gophish..."
# Generate SSL certificates
echo "Generating SSL certificates for Gophish..."
openssl req -newkey rsa:2048 -nodes -keyout gophish-admin.key -x509 -days 365 -out gophish-admin.crt -subj "/C=/ST=/L=/O=/OU=/CN=gophish-admin"
openssl req -newkey rsa:2048 -nodes -keyout gophish.key -x509 -days 365 -out gophish.crt -subj "/C=/ST=/L=/O=/OU=/CN=gophish"
# Final message
echo -e "\e[91m\e[1mNow please open the config.json file and change the admin_server listen url to ip address of the machine\e[0m\e[93m"

# Set execute permission for Gophish binary
chmod +x ./gophish
