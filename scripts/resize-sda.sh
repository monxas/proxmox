# one liner 
# curl -sSL https://raw.githubusercontent.com/monxas/proxmox/develop/scripts/resize-sda.sh | bash
#!/bin/bash
set -e

apt-get update
apt-get install -y parted

{
  echo "resizepart 1"
  echo "Fix"
  echo "1"
  echo "Yes"
  echo "-0"
  echo "quit"
} | parted /dev/sda

reboot
