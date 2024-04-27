#!/bin/bash

# Check if script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Install XFCE and related packages
apt update
apt install -y xserver-xorg xfce4 xfce4-goodies chromium fonts-lohit-deva-nepali || {
    echo "Failed to install XFCE and related packages. Exiting."
    exit 1
}

# Set XFCE as default graphical target
systemctl set-default graphical.target || {
    echo "Failed to set XFCE as default graphical target. Exiting."
    exit 1
}

# Reconfigure lightdm
dpkg-reconfigure lightdm || {
    echo "Failed to reconfigure lightdm. Exiting."
    exit 1
}

# Set XFCE as the default session manager
update-alternatives --set x-session-manager /usr/bin/startxfce4 || {
    echo "Failed to set XFCE as the default session manager. Exiting."
    exit 1
}

# Installation completed successfully
echo "XFCE Installed!"
