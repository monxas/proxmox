#!/bin/bash
set -e

# Variables
device="/dev/sda"
partition_number="3"
partition_type="30"
lv_root="/dev/ubuntu-vg/ubuntu-lv"
lv_data="/dev/ubuntu-vg/ubuntu-lv"

# Prompt the user for the size to increase in GB
read -p "Enter the size to increase in GB: " increase_size

# Login as root if needed (not needed for proxmox)
sudo su

# List disks and partitions
fdisk -l

# List volume groups
vgdisplay

# List logical volumes
lvdisplay

# Edit partitions with fdisk, change device id as needed
(
echo "p"
echo "d"
echo "$partition_number"
echo "n"
echo "p"
echo "$partition_number"
echo ""
echo ""
echo "n"
echo "t"
echo "$partition_number"
echo "$partition_type"
echo "w"
) | sudo fdisk $device

# List disks and partitions, noting the size increase
fdisk -l

# Extend the existing physical volume
pvresize ${device}${partition_number}

# Extend the pve-root logical volume with the user-specified size
lvresize -L +${increase_size}G $lv_root

# Extend the underlying file system
resize2fs $lv_root

# List logical volumes, noting root is now larger by the specified size
lvdisplay

# Extend the data to 100% available free space
lvextend -l +100%FREE $lv_data

# List logical volumes, noting data is now over 35GB
lvdisplay
