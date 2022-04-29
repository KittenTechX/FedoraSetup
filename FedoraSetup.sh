#!/usr/bin/bash
# Purpose: To setup Fedora 35 from a fresh install
# Author: Minimeeh
# Depencencies: Fedora 35, DNF and an Internet Connection

# Optimise the DNF config file
ammend_dnf () {
	echo "Optimising the DNF Config..."
	sleep 1
	echo "fastestmirror=True" >> /etc/dnf/dnf.conf
	echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
	echo "defaultyes=True" >> /etc/dnf/dnf.conf
	echo "Optimisation complete."
	echo " "
}

# Update System
update_system () {
	echo "Checking the system for updates..."
	sleep 1
	dnf update
	echo " "
	echo "System updated successfully!"
	echo " "
}

# Enable RPM Fusion (Free)
free_fusion () {
	echo "Enabling RPM Fusion (Free)..."
	sleep 1
	dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
	echo " "
	echo "RPM Fusion (Free) Enabled!"
	echo " "
}

# Enable RPM Fusion (Non-Free)
nonfree_fusion () {
	echo "Enabling RPM Fusion (Non-Free)..."
	sleep 1
	dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	echo " "
	echo "RPM Fusion (Non-Free) Enabled!"
	echo " "
}

# Install Multimedia Codecs
multimedia_codecs () {
	echo "Installing Multimedia Codecs..."
	sleep 1
	dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
	dnf install lame\* --exclude=lame-devel
	dnf group upgrade --with-optional Multimedia
	echo " "
	echo "Multimedia Codecs installed successfully."
	echo " "
}

# Fedora Install Script
fedora_setup () {
	clear
	ammend_dnf
	update_system
	free_fusion
	nonfree_fusion
	multimedia_codecs
	update_system
	sleep 1
	echo "The script is now complete."
	read -p 'Please press enter to close the script...'
}

# Asks the user for consent before running the script
consent_check () {
	clear
	echo "Would you like to run this script? (y/n)"
	read -p 'Choice: ' consent
	if [[ $consent == "y" || $consent == "Y" ]]; then
		fedora_setup
	elif [[ $consent == "n" || $consent == "N" ]]; then
		clear
		echo "You chose not run the script."
		echo "Exiting Script..."
		sleep 2
	else
		clear
		echo "Choice not recognised, please try again!"
		sleep 4
		consent_check
	fi
}

# Root-Permission Check
root_check () {
	if [[ $USER == "root" ]]; then
		# Script is being run with 'sudo' or as 'root'
		consent_check
	else
		echo "You do not have permission to run this script!"
		echo "Please run with 'sudo ./FedoraScript.sh'"
		sleep 3
	fi
}

root_check
