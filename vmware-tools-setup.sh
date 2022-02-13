#!/bin/bash

# for x in {0..6}; do sudo mkdir -p /etc/init.d/rc$x.d; done
# sudo mount /dev/cdrom /mnt
# tar xf /mnt/VMwareTools*.tar.gz -C /tmp
# 
# cat > /tmp/answer << __ANSWER__
# yes
# /usr/bin
# /etc
# /etc/init.d
# /usr/sbin
# /usr/lib/vmware-tools
# yes
# /usr/share/doc/vmware-tools
# yes
# yes
# no
# no
# yes
# no
# __ANSWER__
# 
# sudo perl /tmp/vmware-tools-distrib/vmware-install.pl < /tmp/answer
# 
# sudo pacman -S --noconfirm asp
# cd /tmp
# asp checkout open-vm-tools
# cd open-vm-tools/repos/community-x86_64/
# makepkg -s --asdeps --noconfirm
# sudo cp vm* /usr/lib/systemd/system
# sudo systemctl enable vmware-vmblock-fuse
# sudo systemctl enable vmtoolsd
# 

git clone https://github.com/rasa/vmware-tools-patches.git /tmp/vmware-tools-patches
sudo sh /tmp/vmware-tools-patches/patched-open-vm-tools.sh

sudo pacman -S --noconfirm gtkmm3 xf86-input-vmmouse xf86-video-vmware mesa
