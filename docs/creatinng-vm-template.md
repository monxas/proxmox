# Creating a Virtual Machine Template (Class 6)

## Overview

In this guide, we'll learn how to create a virtual machine template in Proxmox to simplify the process of launching virtual machines. This guide is based on class 6 of the Proxmox course.

## Steps

### 1. Prepare the Virtual Machine

Before converting a virtual machine into a template, there are a few things to clean up and prepare:

#### a. Install Cloud-Init

```bash
sudo apt search cloud-init
sudo apt install cloud-init
```

#### b. Delete SSH Host Keys

```bash
cd /etc/ssh/
sudo rm ssh_host_*
```

#### c. Empty the Machine ID File

```bash
sudo truncate -s 0 /etc/machine-id
```

#### d. Check and Create Symbolic Link for Machine ID

```bash
ls -l /var/lib/dbus/machine-id
sudo ln -s /etc/machine-id /var/lib/dbus/machine-id
```

#### e. Clean Up the Template

```bash
sudo apt clean
sudo apt autoremove
```

#### f. Power Off the Virtual Machine

```bash
sudo poweroff
```

### 2. Convert the Virtual Machine to a Template

Right-click on the virtual machine in Proxmox, and click "Convert to Template".

### 3. Edit Hardware and Cloud-Init Settings

- Remove the ISO attachment.
- Add a Cloud-Init drive.
- Edit the default username and password.

### 4. Create New Virtual Machines from the Template

Right-click on the template and click "Clone". Configure the new virtual machine as desired, and start it.

### 5. Update Hostnames of the New Virtual Machines

Edit `/etc/hostname` and `/etc/hosts` on each new virtual machine to set the correct hostname.

```bash
sudo nano /etc/hostname
sudo nano /etc/hosts
```

Reboot the new virtual machines.

```bash
sudo reboot
```
