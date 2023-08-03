#!/usr/bin/env bash

set -euo pipefail

echo "In init.sh with arguments '$1' '$2'"

linux_user=$1
linux_user_fullname=$2
windows_user_profile=`wslpath "$3"`

echo "Linux path to windows user profile: $windows_user_profile"

echo "Setting up users and groups"
adduser -g "$linux_user_fullname" "$linux_user" -D
adduser "$linux_user" sudo

echo "Installing packages"
apt install vim sudo curl wget

echo "Configuring passwordless sudo for wheel members"
echo '%sudo ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers

echo "Setting Permissions"
mkdir -m 0755 /home/$linux_user
chown "$linux_user" /home/$linux_user

echo "Setting permissions for Windows files mounted in Linux"
our_uid=`id -u "$linux_user"`
our_gid=`id -g "$linux_user"`
echo "[automount]" > /etc/wsl.conf
echo "options=uid=$our_uid,gid=$our_gid,umask=000,fmask=000,dmask=000" >> /etc/wsl.conf
echo "" >> /etc/wsl.conf

echo "Done with init.sh"