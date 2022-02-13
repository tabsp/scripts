#!/bin/bash

timedatectl set-ntp true

fdisk /dev/sda <<EOF
g
n
1

+512M
n
3

+4G
n
2


w
EOF

mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkswap /dev/sda3
swapon /dev/sda3

mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

sed -i '1i\Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist

pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt <<EOFARCH
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

sed -i 's/^#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
sed -i 's/^#zh_CN.UTF-8/zh_CN.UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

pacman -S --noconfirm dhcp networkmanager zsh sudo vi git
systemctl enable NetworkManager

echo cc > /etc/hostname
cat >> /etc/hosts <<EOF
127.0.0.0    cc
::1          cc
127.0.1.1    cc.localdomain    cc
EOF

passwd<<EOF
1
1
EOF

useradd -m -G wheel -s /bin/zsh c
passwd c<<EOF
1
1
EOF

pacman -S --noconfirm grub efibootmgr intel-ucode os-prober
mkdir /boot/grub
grub-mkconfig > /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=/boot

EOFARCH
