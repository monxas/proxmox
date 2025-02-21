# one liner 
# curl -sSL https://raw.githubusercontent.com/monxas/proxmox/develop/scripts/resize-sda.sh | bash
#!/bin/bash
set -e

apt-get update
apt-get install -y parted e2fsprogs cloud-guest-utils

if ! command -v growpart >/dev/null; then
  echo "growpart command not found. Aborting." >&2
  exit 1
fi

# Extend partition 1 to occupy all available space on /dev/sda
growpart /dev/sda 1

# Resize the ext4 filesystem on /dev/sda1 to fill the new partition size
resize2fs /dev/sda1

echo "New partition table (parted /dev/sda print):"
parted /dev/sda print

echo "Block devices (lsblk):"
lsblk

echo "Filesystem usage (df -h):"
df -h

# Victory from Entourage!
