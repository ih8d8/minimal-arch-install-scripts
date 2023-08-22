#!/bin/bash

set -euo pipefail

# set settings related to locale
sed -i -e 's|#fa_IR UTF-8|fa_IR UTF-8|' -e 's|#en_US.UTF-8 UTF-8|en_US.UTF-8 UTF-8|' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >/etc/locale.conf

# set the time zone
echo -n "Enter Time Zone: "
read -r TIME_ZONE
ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime
hwclock --systohc

# set hostname
echo -n "Enter hostname: "
read -r HOSTNAME
echo "${HOSTNAME}" >/etc/hostname

# configure hosts file
cat <<EOF >>/etc/hosts
127.0.0.1    localhost
::1          localhost
127.0.1.1    ${HOSTNAME}
EOF

# set root user password
passwd

# configure mkinitcpio
sed -i '/^HOOKS/s/\(block \)\(.*filesystems\)/\1encrypt lvm2 \2/' /etc/mkinitcpio.conf

# generate initramfs for linux and linux-lts
mkinitcpio -p linux
mkinitcpio -p linux-lts

# install and configure refind
refind-install

# enable NetworkManager systemd service
systemctl enable NetworkManager
