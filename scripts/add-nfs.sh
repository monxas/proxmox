# one liner 
# sudo apt update && sudo apt install -y nfs-common && sudo mkdir -p /mnt/nfs_media && echo '192.168.0.237:/Volume1/Media /mnt/nfs_media nfs rw,relatime,vers=4.1,nofail 0 0' | sudo tee -a /etc/fstab && sudo mount -a
# curl -sSL https://raw.githubusercontent.com/monxas/proxmox/develop/scripts/add-nfs.sh | bash

#!/bin/bash

# Update package list and install NFS utilities
sudo apt update && sudo apt install -y nfs-common

# Create the mount point directory
sudo mkdir -p /mnt/nfs_media

# Add the NFS mount entry to /etc/fstab
echo '192.168.0.237:/Volume1/Media /mnt/nfs_media nfs rw,relatime,vers=4.1,nofail 0 0' | sudo tee -a /etc/fstab

# Mount all filesystems defined in /etc/fstab
sudo mount -a

echo "NFS setup complete."
