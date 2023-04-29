Here are some useful commands for working with Proxmox VE:

1. View Proxmox VE version: 
`pveversion`

2. View Proxmox VE cluster status:
`pvecm status`

3. Restart Proxmox VE services:
`systemctl restart pve-cluster`

4. Check Proxmox VE service status:
`systemctl status pve-cluster`

5. View Proxmox VE log file:
`less /var/log/pveproxy.log`

6. View list of virtual machines and containers:
`qm list` or `pct list`

7. Create a new virtual machine:
`qm create [vmid]`

8. Start a virtual machine:
`qm start [vmid]`

9. Stop a virtual machine:
`qm stop [vmid]`

10. Clone a virtual machine:
`qm clone [vmid] [new-vmid]`

11. Create a new container:
`pct create [vmid]`

12. Start a container:
`pct start [vmid]`

13. Stop a container:
`pct stop [vmid]`

14. Clone a container:
`pct clone [vmid] [new-vmid]`

15. Remove a virtual machine or container:
`qm destroy [vmid]` or `pct destroy [vmid]`

16. View network interface configuration:
`ip addr show`

17. View network routing table:
`ip route show`

18. Configure network interface settings:
`nano /etc/network/interfaces`

19. Update package list:
`apt update`

20. Upgrade all installed packages:
`apt upgrade`

21. Reconfigure OpenSSH server:
`dpkg-reconfigure openssh-server`

