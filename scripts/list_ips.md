# Proxmox List IPs

This script helps you list the IP addresses of both containers (CTs) and virtual machines (VMs) on a Proxmox server.

## Requirements

- Proxmox server
- SSH access to the Proxmox server
- `jq` command installed on the Proxmox server
- `qemu-guest-agent` installed on each VM

## Installation

1. Install the `jq` command on the Proxmox server:

```bash
apt-get update && apt-get install -y jq
```

2. Ensure that the `qemu-guest-agent` package is installed and running on each VM:

```bash
# On Debian/Ubuntu-based VMs
sudo apt-get update && sudo apt-get install -y qemu-guest-agent
sudo systemctl enable --now qemu-guest-agent

# On CentOS/RHEL-based VMs
sudo yum install -y qemu-guest-agent
sudo systemctl enable --now qemu-guest-agent
```

3. Copy the `list_ips.sh` script to the Proxmox server, and grant execute permissions:

```bash
chmod +x list_proxmox_ips.sh
```

## Usage

Run the script on the Proxmox server to list the IP addresses of all containers and VMs:

```bash
./list_ips.sh
```

The script will output the IP addresses along with their respective CTIDs and VMIDs.

