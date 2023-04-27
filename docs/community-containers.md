# Proxmox - using and Launching Your First Community Container

### Linux Containers (LXC)

Linux Containers, also known as LXC or Lexi, can be launched on any Linux distribution like Debian, Ubuntu, or OpenSUSE. They are fully integrated into the Proxmox web console, which makes managing them very easy.

## Creating a Container

### Downloading a Template

1. Click on "Local" and then click on "Templates".
2. Search for the desired template (e.g., Ubuntu 20.04 LTS).
3. Click on "Download".

### Configuring the Container

1. Click on "Create CT" (CT stands for Container).
2. Choose the host you want the container to run on.
3. Set the Container ID and Hostname.
4. Set a root password for the container.
5. Choose the template you downloaded earlier.
6. Set the root disk size.
7. Allocate CPU cores and memory for the container.
8. Configure networking settings (e.g., use DHCP for IP addresses).
9. Configure DNS settings (e.g., use host information).
10. Click "Finish" to create the container.

## Starting the Container and Installing an Application

1. Right-click on the container and click "Start".
2. Open the console to see the container boot up.
3. Log in as the root user with the password you set earlier.
4. Install an application (e.g., Apache web server).

## Accessing the Container via SSH

1. Obtain the container's IP address by running `ip a` in the console.
2. SSH into the container using the root user and the container's IP address.

## Adding a New User to the Container

1. Run `adduser <username>` to add a new user to the container.
2. Set a password for the new user.
3. Add the new user to the sudo group by running `usermod -aG sudo <username>`.

## Testing the Application

1. Access the application in your web browser using the container's IP address.
2. Verify that the application is running successfully.
