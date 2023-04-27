# LearnLinuxTV: Installing Windows on Proxmox VM

In this guide, you will learn how to install a Windows virtual machine (VM) on Proxmox.

## Requirements

- Proxmox installed and configured
- Windows ISO image (e.g., Windows Server or Windows 10)
- VirtIO Windows drivers ISO image

## Steps

### 1. Prepare the required files

1. Download the Windows ISO image and VirtIO Windows drivers ISO image.
2. Upload both ISO images to your Proxmox ISO repository.

### 2. Create a virtual machine

1. In the Proxmox web interface, create a new virtual machine.
2. Enter a unique ID and name for the virtual machine.
3. Select your ISO repository and the Windows ISO image.
4. Choose "Microsoft Windows" as the OS type and select the appropriate version.
5. Enable the QEMU agent and set the SCSI controller to "VirtIO SCSI".
6. Set the bus to "SCSI" and configure the disk size (64 GB recommended).
7. Enable "Discard" for SSDs and set cache to "Write back".
8. Configure CPU and memory based on your requirements.
9. Choose a network bridge.
10. Click "Finish" without starting the VM.

### 3. Add a second CD-ROM drive

1. Go to the "Hardware" tab of the virtual machine.
2. Add another CD-ROM drive.
3. Select the ISO repository and the VirtIO Windows drivers ISO image.

### 4. Install Windows on the virtual machine

1. Start the virtual machine and open the console.
2. Go through the Windows installation process.
3. When prompted to choose a hard drive, click "Load driver".
4. Browse to the VirtIO driver folder on the second CD-ROM drive.
5. Select the appropriate driver folder for your Windows version.
6. Continue with the Windows installation and wait for it to complete.

### 5. Install the missing drivers

1. In Windows, open Device Manager.
2. Right-click on any devices with missing drivers and choose "Update driver".
3. Browse to the appropriate driver folder on the VirtIO CD-ROM.
4. Repeat for all devices with missing drivers.

### 6. Install the QEMU agent

1. In Windows, open File Explorer and navigate to the VirtIO CD-ROM drive.
2. Go to the "guest-agent" folder.
3. Double-click on the appropriate QEMU agent installer (e.g., 64-bit version).
4. Finish the installation.

You now have a Windows virtual machine running on Proxmox. If you need to activate Windows, you can do so by entering a product key in the Windows settings.
