#!/bin/bash
set -e
set -x

# Function to list available devices
function list_devices() {
    lsblk -dpno NAME,SIZE,TYPE | grep -w "disk" | awk '{print $1 " " $2}'
}

# Function to list available logical volumes
function list_logical_volumes() {
    lvdisplay | grep "LV Path" | awk '{print $3}'
}

# Prompt user to select a device
echo "Available devices:"
list_devices
echo
read -p "Enter the device you want to resize (e.g. /dev/sda): " device

# Prompt user to select a logical volume
echo "Available logical volumes:"
list_logical_volumes
echo
read -p "Enter the logical volume you want to resize (e.g. /dev/ubuntu-vg/ubuntu-lv): " lv_root

# Prompt user to enter the desired size in GB to increase
read -p "Enter the size in GB to increase the logical volume: " size_gb

# Get the partition number
partition_number=$(lsblk -o NAME,TYPE,MOUNTPOINT | grep -w "lvm" | head -n 1 | cut -d"p" -f2)

# Edit partitions with fdisk
{
    echo "p"
    echo "d"
    echo "$partition_number"
    echo "n"
    echo "p"
    echo "$partition_number"
    echo ""
    echo ""
    echo "t"
    echo "$partition_number"
    echo "30"
    echo "w"
} | fdisk $device

# List disks and partitions, noting the size increase
fdisk -l

# Extend the existing physical volume
pvresize "${device}${partition_number}"

# Extend the logical volume to the desired size
lvresize -L +${size_gb}G $lv_root

# Extend the underlying file system
resize2fs $lv_root

# List logical volumes, noting the size increase
lvdisplay
