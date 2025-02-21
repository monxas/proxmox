#!/bin/bash

# Predefined folder options
OPTIONS=(Media Matematico backup nexus Custom)

# Prompt user to select a folder
PS3="Select an NFS folder to mount: "
select FOLDER in "${OPTIONS[@]}"; do
  if [[ -n "$FOLDER" ]]; then
    if [[ "$FOLDER" == "Custom" ]]; then
      read -rp "Enter custom NFS folder name: " FOLDER
    fi
    break
  else
    echo "Invalid selection. Try again."
  fi
done

# Define server and local mount point
NFS_SERVER="192.168.0.237:/Volume1/$FOLDER"
MOUNT_POINT="/mnt/nfs_${FOLDER,,}"  # Convert to lowercase

# Update package list and install NFS utilities
sudo apt update && sudo apt install -y nfs-common

# Create the mount point directory
sudo mkdir -p "$MOUNT_POINT"

# Add the NFS mount entry to /etc/fstab if it doesn't already exist
grep -qxF "$NFS_SERVER $MOUNT_POINT nfs rw,relatime,vers=4.1,nofail 0 0" /etc/fstab || \
  echo "$NFS_SERVER $MOUNT_POINT nfs rw,relatime,vers=4.1,nofail 0 0" | sudo tee -a /etc/fstab

# Reload systemd to recognize changes in /etc/fstab
sudo systemctl daemon-reload

# Mount all filesystems defined in /etc/fstab
sudo mount -a

# Check if the mount was successful
if mountpoint -q "$MOUNT_POINT"; then
  echo "NFS setup complete and mount successful at $MOUNT_POINT."
else
  echo "NFS setup complete but mount failed."
fi
