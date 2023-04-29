#!/bin/bash
set -e

# Function to display available devices
list_devices() {
  lsblk -d -o NAME,SIZE,TYPE | grep "disk"
}

# Function to display available logical volumes
list_logical_volumes() {
  lvdisplay --columns --separator ',' --noheading -o lv_name,vg_name | awk -F ',' '{print "/dev/"$2"/"$1}'
}

# Prompt the user to select a device
echo "Available devices:"
list_devices
read -p "Enter the device to resize (e.g., /dev/sda): " device

# Prompt the user to select a logical volume
echo "Available logical volumes:"
list_logical_volumes
read -p "Enter the root logical volume path (e.g., /dev/ubuntu-vg/ubuntu-lv): " lv_root

# Variables
partition_number="3"
partition_type="30"

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

# Extend the root logical volume with the user-specified size
lvresize -L +${increase_size}G $lv_root

# Extend the underlying file system
resize2fs $lv_root

# List logical volumes, noting root is now larger by the specified size
lvdisplay
