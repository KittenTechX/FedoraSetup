# The Ultimate Script to Setup Fedora 35-36
The purpose of this script is to simplify the setting up of Fedora 35-36 by optimising the DNF Config for the fastest download and update speeds; update the system; install RPM Fusion Free & Non-Free; enable the Flathub repository for Flatpaks; install the essential multimedia codecs; and do a final check for system updates.

## Which script is right for you?
- If you are the one line type of person and just want all of the essential tweaks to Fedora 35-36 from a fresh install then `./FedoraSetup.sh` is the choice for you!

- If you are the type of person who wants more choice when setting up the essential tweaks, i.e. you don't want to install RPM Fusion Non-Free but you do want to install RPM Fusion Free then `./FedoraSetup-Interactive.sh` is the choice for you!

## How to run the scripts?
#### For the main script (./FedoraSetup.sh)
- Make the script executable
```
chmod 755 ./FedoraSetup.sh
```
- Run the script
```
sudo ./FedoraSetup.sh
```

#### For the interactive script (./Fedora-Setup-Interactive.sh)
- Make the script executable
```
chmod 755 ./Fedora-Setup-Interactive.sh
```
- Run the script:
```
sudo ./Fedora-Setup-Interactive.sh
```
