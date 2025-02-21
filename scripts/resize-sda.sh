# one liner 
# curl -sSL https://raw.githubusercontent.com/monxas/proxmox/develop/scripts/resize-sda.sh | bash
#!/bin/bash
set -e

apt-get update
apt-get install -y parted e2fsprogs

# Resize partition 1 to use the entire disk (non-interactively)
parted -s /dev/sda resizepart 1 100%

# Expand the ext4 filesystem on /dev/sda1 to fill the new partition size
resize2fs /dev/sda1

echo "New partition table (parted /dev/sda print):"
parted /dev/sda print

echo "Block devices (lsblk):"
lsblk

echo "Filesystem usage (df -h):"
df -h
