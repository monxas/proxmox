# proxmox

Personal notes, scripts, and docker-compose stacks for self-hosting on
[Proxmox VE](https://www.proxmox.com/). Tutorials are written for my own
homelab but should generalise — PRs welcome.

> Not an official guide. These are working notes from running a Proxmox
> cluster at home. Read carefully before applying to production.

## Contents

### 📚 Tutorials & docs

| File | Topic |
| ---- | ----- |
| [docs/vms-vs-containers.md](docs/vms-vs-containers.md) | When to use VMs vs LXC containers |
| [docs/create-vm.md](docs/create-vm.md) | Creating a VM from ISO |
| [docs/creatinng-vm-template.md](docs/creatinng-vm-template.md) | Cloud-init VM templates |
| [docs/create-container.md](docs/create-container.md) | Creating an LXC container |
| [docs/create-template-container.md](docs/create-template-container.md) | LXC template containers |
| [docs/community-containers.md](docs/community-containers.md) | Community LXC scripts (tteck) |
| [docs/windows-vm.md](docs/windows-vm.md) | Windows VM with VirtIO drivers |
| [docs/backups.md](docs/backups.md) | Snapshots vs backups, restore, automation |
| [docs/firewalls.md](docs/firewalls.md) | CrowdSec + Proxmox firewall |
| [docs/calibre.md](docs/calibre.md) | Self-hosted Calibre book server |
| [userful-commands.md](userful-commands.md) | Cheatsheet of `qm` / `pct` / `pvecm` commands |

### 🛠️ Scripts

All scripts live under [scripts/](scripts/). Run them inside a VM/container,
not on the Proxmox host (unless noted).

| Script | Purpose |
| ------ | ------- |
| [`scripts/system_check.sh`](scripts/system_check.sh) | Post-install health check: updates, SSH, user, firewall, fail2ban, mounts |
| [`scripts/post-clone-ubuntu.sh`](scripts/post-clone-ubuntu.sh) | Fix machine-id, hostname, SSH host keys after cloning an Ubuntu template |
| [`scripts/add-nfs.sh`](scripts/add-nfs.sh) | Mount NFS share with `/etc/fstab` entry |
| [`scripts/increase-lvm.sh`](scripts/increase-lvm.sh) | Grow LVM physical/logical volume into unused disk space |
| [`scripts/resize-sda.sh`](scripts/resize-sda.sh) | Resize root partition (sda) after disk expansion |
| [`scripts/list_ips.sh`](scripts/list_ips.sh) | Enumerate IPs of all running VMs + LXCs ([docs](scripts/list_ips.md)) |
| [`scripts/bitcoin-node.sh`](scripts/bitcoin-node.sh) | Install + run a Bitcoin Core node |

### 🐳 Compose stacks

| Stack | Notes |
| ----- | ----- |
| [`compose/media_server/`](compose/media_server/) | Sonarr/Radarr/Jellyfin/qBittorrent stack |

## Quick start

```bash
# Clone on the VM/container that needs it
git clone https://github.com/monxas/proxmox.git
cd proxmox

# Make a script executable + run
chmod +x scripts/system_check.sh
sudo ./scripts/system_check.sh
```

For docs, just read them directly on GitHub or with your favourite Markdown
viewer.

## Why this exists

Running a Proxmox cluster long-term means you accumulate scripts and lessons
that don't fit anywhere else. This repo is where mine live. If something here
saves you an hour, it has paid for itself.

## Related

- [tteck/Proxmox](https://github.com/tteck/Proxmox) — the canonical
  community scripts collection (mentioned in `docs/community-containers.md`)

## License

No explicit license yet. Use at your own risk; attribute back if you copy
significantly.
