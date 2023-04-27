# Proxmox Course: Creating a Virtual Machine

This document provides a step-by-step guide on how to create a virtual machine on Proxmox based on the provided transcript.

## Prerequisites

1. A working Proxmox installation.
2. Adequate hardware resources (RAM, CPU, storage).

## Steps

1. **Verify your available resources**: Check your Proxmox host's available resources (RAM, CPU) to ensure you have enough to create a virtual machine.

2. **Download an ISO image**: If you don't already have an ISO image for the operating system you want to install, download it directly to Proxmox:
   - Navigate to `Storage > local > Content > Upload`.
   - Paste the URL of the ISO image and click "Download".

3. **Create the virtual machine**:
   - Click on "Create VM" in the Proxmox web interface.
   - Assign a unique ID and a name for your virtual machine.
   - Select the ISO image you downloaded in step 2.
   - Choose the operating system type (e.g. Linux, Windows, etc.).
   - Configure the system options, such as storage, size, and number of CPU cores.
   - Set the amount of RAM for the virtual machine.
   - Choose the network settings.
   - Review the summary, and click "Finish" to create the virtual machine.

4. **Start the virtual machine**: Select the created virtual machine in Proxmox and click "Start".

5. **Access the virtual machine console**: Click on "Console" in the Proxmox web interface to access the virtual machine.

6. **Install the operating system**: Follow the installation instructions for your chosen operating system (e.g. Ubuntu Server).

7. **SSH into the virtual machine**: Use an SSH client to connect to the virtual machine using its IP address.

8. **Update the operating system**: Run updates on your virtual machine to ensure it's up-to-date.

9. **Install the QEMU guest agent**: Install the `qemu-guest-agent` package for your distribution and enable it in the virtual machine settings in Proxmox.

10. **Restart the virtual machine**: Restart the virtual machine to apply any changes made during the previous steps.

11. **Test the virtual machine**: Install and test an application on your virtual machine (e.g. Apache web server) to ensure it's working as expected.

You have now successfully created a virtual machine on Proxmox. In the next part of the course, you will learn how to create a template of the virtual machine to save time when creating additional virtual machines.
