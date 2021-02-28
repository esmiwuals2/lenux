#!/bin/bash
set -e
echo "Welcome to the Lenux 1.0.1 installer script!"
echo "Setting up..."
dd if=/dev/zero of=lenux.img bs=512 count=4194304
sudo losetup -P loop8 lenux.img
sudo fdisk /dev/loop8
sudo mkfs.ext4 /dev/loop8p1
sudo mkdir /mnt/lenux
sudo mount /dev/loop8p1 /mnt/lenux
echo "Installing programs..."
sudo rsync -a dirs/ /mnt/lenux
sudo rsync -a doc/ /mnt/lenux
sudo rsync -a dynamic-linker/ /mnt/lenux
sudo rsync -a grub-cfg/ /mnt/lenux
sudo rsync -a init/ /mnt/lenux
sudo rsync -a kernel/ /mnt/lenux
sudo rsync -a libs/ /mnt/lenux
sudo rsync -a lpm/ /mnt/lenux
sudo rsync -a ls/ /mnt/lenux
sudo rsync -a lsh/ /mnt/lenux
sudo rsync -a node/ /mnt/lenux
sudo rsync -a cat/ /mnt/lenux
echo "Installing GRUB..."
sudo grub-install --target=i386-pc --boot-directory=/mnt/lenux/boot /dev/loop8
echo "Finishing up..."
sudo umount /mnt/lenux
sudo rmdir /mnt/lenux
sudo losetup -d /dev/loop8
echo "Build succeded!"
