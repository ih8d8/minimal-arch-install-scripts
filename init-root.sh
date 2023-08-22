#!/bin/bash

set -euo pipefail

echo "#################### Add New User ####################"
echo -n "Enter new user name: " 
read -r NEW_USER
useradd -m -g wheel ${NEW_USER}
passwd ${NEW_USER}
usermod -aG storage,video,input ${NEW_USER}

echo "#################### Modify /etc/sudoers File ####################"
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
cp sudoers_custom_configs /etc/sudoers.d/

echo "#################### Configure pacman and makepkg ####################"
grep "^Color" /etc/pacman.conf >/dev/null || sed -i "s/^#Color/Color/" /etc/pacman.conf
grep "ILoveCandy" /etc/pacman.conf >/dev/null || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
grep "^ParallelDownloads" /etc/pacman.conf >/dev/null || sed -i "s/^#ParallelDownloads/ParallelDownloads/" /etc/pacman.conf
# Use all cores for compilation.
sed -i "s/-j2/-j$(nproc)/;s/^#MAKEFLAGS/MAKEFLAGS/" /etc/makepkg.conf

echo "#################### Create Swap File ####################"
dd if=/dev/zero of=/swapfile bs=1M count=2048 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' | tee -a /etc/fstab
