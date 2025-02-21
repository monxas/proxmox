# one liner 
# curl -sSL https://raw.githubusercontent.com/monxas/proxmox/develop/scripts/add-nfs.sh | bash
#!/bin/bash
exec </dev/tty

# Predefined folder options
OPTIONS=("Media" "Matematico" "backup" "nexus" "Custom")

# Prompt user to select a folder
echo "Select an NFS folder to mount:"
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

# Convert folder name to lowercase for local mount point
FOLDER_NAME="${FOLDER,,}"

# Define server and local mount point
NFS_SERVER="192.168.0.237:/Volume1/$FOLDER"
MOUNT_POINT="/mnt/nfs_$FOLDER_NAME"

# Update package list and install NFS utilities
sudo apt update && sudo apt install -y nfs-common

# Create the mount point directory
sudo mkdir -p "$MOUNT_POINT"

# Add the NFS mount entry to /etc/fstab if it doesn't already exist
if ! grep -qxF "$NFS_SERVER $MOUNT_POINT nfs rw,relatime,vers=4.1,nofail 0 0" /etc/fstab; then
  echo "$NFS_SERVER $MOUNT_POINT nfs rw,relatime,vers=4.1,nofail 0 0" | sudo tee -a /etc/fstab
fi

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
