#!/usr/bin/bash
# Purpose: To setup Fedora 36 from a fresh install
# Author: KittenTechX
# Depencencies: Fedora 36, DNF and an Internet Connection

# Optimise the DNF config file
ammend_dnf () {
	echo "Optimising the DNF Config..."
	sleep 1
	echo "# Optimisation of the DNF Config by KittenTechX" >> /etc/dnf/dnf.conf
	echo "fastestmirror=True" >> /etc/dnf/dnf.conf
	echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
	echo "defaultyes=True" >> /etc/dnf/dnf.conf
	echo "keepcache=True" >> /etc/dnf/dnf.conf
	echo "# End of ammendments by KittenTechX" >> /etc/dnf/dnf.conf
	echo "Optimisation complete."
	echo " "
}

ammend_dnf_check () {
	echo "Would you like to optimise the DNF Config? (y/n)"
	read -p 'Choice: ' dnfconsent
	if [[ $dnfconsent == "y" || $dnfconsent == "Y" ]]; then
		ammend_dnf
	elif [[ $dnfconsent == "n" || $dnfconsent == "N" ]]; then
		echo "Skipping DNF Optimisation..."
		sleep 1
	else
		clear
		echo "Choice not recognised, please try again!"
		sleep 4
		ammend_dnf_check
	fi
}

# Update System
update_system () {
	echo "Checking the system for updates..."
	sleep 1
	dnf update -y
	echo " "
	echo "System updated successfully!"
	echo " "
}

update_system_check () {
	echo "Would you like to update the system? (y/n)"
	read -p 'Choice: ' updatesystemconsent
	if [[ $updatesystemconsent == "y" || $updatesystemconsent == "Y" ]]; then
		update_system
	elif [[ $updatesystemconsent == "n" || $updatesystemconsent == "N" ]]; then
		echo "Not updating system..."
		sleep 1
	else
		clear
		echo "Choice not recognised, please try again!"
		sleep 4
		update_system_check
	fi
}

# Enable RPM Fusion (Free)
free_fusion () {
	echo "Enabling RPM Fusion (Free)..."
	sleep 1
	dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
	echo " "
	echo "RPM Fusion (Free) Enabled!"
	echo " "
}

free_fusion_check () {
	echo "Would you like to Enable RPM Fusion (Free)? (y/n)"
	read -p 'Choice: ' freefusionconsent
	if [[ $freefusionconsent == "y" || $freefusionconsent == "Y" ]]; then
		free_fusion
	elif [[ $freefusionconsent == "n" || $freefusionconsent == "N" ]]; then
		echo "Not Enabling RPM Fusion (Free)..."
		sleep 1
	else
		clear
		echo "Choice not recognised, please try again!"
		sleep 4
		free_fusion_check
	fi
}

# Enable RPM Fusion (Non-Free)
nonfree_fusion () {
	echo "Enabling RPM Fusion (Non-Free)..."
	sleep 1
	dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
	echo " "
	echo "RPM Fusion (Non-Free) Enabled!"
	echo " "
}

nonfree_fusion_check () {
	echo "Would you like to Enable RPM Fusion (Non-Free)? (y/n)"
	read -p 'Choice: ' nonfreefusionconsent
	if [[ $nonfreefusionconsent == "y" || $nonfreefusionconsent == "Y" ]]; then
		nonfree_fusion
	elif [[ $nonfreefusionconsent == "n" || $nonfreefusionconsent == "N" ]]; then
		echo "Not Enabling RPM Fusion (Free)..."
		sleep 1
	else
		clear
		echo "Choice not recognised, please try again!"
		sleep 4
		nonfree_fusion_check
	fi
}

# Enable Flathub Repo for Flatpaks
flathub() {
	echo "Enabling Flathub Repo for Flatpaks..."
	sleep 1
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	echo " "
	echo "Flathub Repo Enabled!"
	echo " "
}

flathub_check() {
	echo "Would you like to Enable the Flathub Repository for Flatpaks? (y/n)"
	read -p 'Choice: ' flathubconsent
	if [[ $flathubconsent == "y" || $flathubconsent == "Y" ]]; then
		flathub
	elif [[ $flathubconsent == "n" || $flathubconsent == "N" ]]; then
		echo "Not Enabling the Flathub Repository for Flatpaks..."
		sleep 1
	else
		clear
		echo "Choice not recognised, please try again!"
		sleep 4
		flathub_check
	fi
}

# Install Multimedia Codecs
multimedia_codecs () {
	echo "Installing Multimedia Codecs..."
	sleep 1
	dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
	dnf install lame\* --exclude=lame-devel -y
	dnf group upgrade --with-optional Multimedia -y
	echo " "
	echo "Multimedia Codecs installed successfully."
	echo " "
}

multimedia_codecs_check () {
	echo "Would you like to Install Essential Multimedia Codecs? (y/n)"
	read -p 'Choice: ' multimediacodecsconsent
	if [[ $multimediacodecsconsent == "y" || $multimediacodecsconsent == "Y" ]]; then
		nonfree_fusion
	elif [[ $multimediacodecsconsent == "n" || $multimediacodecsconsent == "N" ]]; then
		echo "Not Installing Multimedia Codecs..."
		sleep 1
	else
		clear
		echo "Choice not recognised, please try again!"
		sleep 4
		multimedia_codecs_check
	fi
}

# Fedora Install Script
fedora_setup () {
	clear
	ammend_dnf_check
	update_system_check
	free_fusion_check
	nonfree_fusion_check
	flathub_check
	multimedia_codecs_check
	update_system_check
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
		echo "Please run with 'sudo ./FedoraSetup-Interactive.sh'"
		sleep 3
	fi
}

root_check
