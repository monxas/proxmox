# Proxmox Course: Launching Our First Container

Hello again everyone and welcome back to my Proxmox course. In today's class, we're going to be launching our very first container. I'm going to show you the entire process.

## Linux Containers (LXC)

Proxmox uses Linux Containers, or LXC for short. LXC containers are actually pronounced "lexi" in the industry. Lexi containers are more VM-like than other container types, as they automatically save their state.

## Creating a Container

### Downloading a Template

1. Click on **Local** to access the different types of storage volumes.
2. Select **Container Templates**.
3. Click on **Templates** and choose the desired template (e.g., Ubuntu 20.04 LTS).
4. Click **Download**.

### Configuring the Container

1. Click on **Create CT**.
2. Choose the host for the container.
3. Set the **Container ID**.
4. Provide a **Hostname**.
5. Create a **Password** for the instance.
6. Optionally, load an **SSH public key**.
7. Choose the **Template** for the container.
8. Set the **Root Disk** size.
9. Allocate **CPU** cores.
10. Allocate **Memory**.
11. Configure **Networking** (e.g., DHCP).
12. Set **DNS** options (e.g., use host information).

## Starting and Accessing the Container

1. Enable **Start at boot** if desired.
2. Start the container.
3. Access the container through the console or SSH.
4. Install desired applications within the container (e.g., Apache).

And that's it! You've successfully created a container within Proxmox. Feel free to experiment with creating additional containers for various applications.
