# one liner 
# curl -sSL https://raw.githubusercontent.com/monxas/proxmox/develop/scripts/add-nfs.sh | bash
#!/bin/bash
exec </dev/tty
exec >/dev/tty

PS3="Enter your choice (number): "

OPTIONS=("Media" "Matematico" "backup" "nexus" "Custom")

echo "Select an NFS folder to mount:"
select FOLDER in "${OPTIONS[@]}"; do
  if [[ -n "$FOLDER" ]]; then
    if [[ "$FOLDER" == "Custom" ]]; then
      read -rp "Enter custom NFS folder name: " FOLDER < /dev/tty
    fi
    break
  else
    echo "Invalid selection. Try again." > /dev/tty
  fi
done

FOLDER_NAME="${FOLDER,,}"
NFS_SERVER="192.168.0.237:/Volume1/$FOLDER"
MOUNT_POINT="/mnt/nfs_$FOLDER_NAME"

sudo apt update && sudo apt install -y nfs-common
sudo mkdir -p "$MOUNT_POINT"

if ! grep -qxF "$NFS_SERVER $MOUNT_POINT nfs rw,relatime,vers=4.1,nofail 0 0" /etc/fstab; then
  echo "$NFS_SERVER $MOUNT_POINT nfs rw,relatime,vers=4.1,nofail 0 0" | sudo tee -a /etc/fstab
fi

sudo systemctl daemon-reload
sudo mount -a

if mountpoint -q "$MOUNT_POINT"; then
  echo "NFS setup complete and mount successful at $MOUNT_POINT."
else
  echo "NFS setup complete but mount failed."
fi

# Victory from Entourage!
