#!/bin/bash

# List container IPs
echo "Container IPs:"
for ctid in $(pct list | awk 'NR>1 {print $1}'); do
    ip=$(pct exec $ctid -- hostname -I | awk '{print $1}')
    echo "CTID $ctid: $ip"
done

echo ""

# List VM IPs
echo "VM IPs:"
for vmid in $(qm list | awk 'NR>1 {print $1}'); do
    if ! qm status $vmid | grep -q "status: running"; then
        echo "VMID $vmid: VM is not running"
    else
        ip=$(qm agent $vmid network-get-interfaces | jq -r '.[] | select(.["hardware-address"] != null) | .["ip-addresses"][] | select(.["ip-address-type"] == "ipv4" and .["ip-address"] != "127.0.0.1") | .["ip-address"]' | head -n 1)
        echo "VMID $vmid: $ip"
    fi
done
