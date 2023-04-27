# Creating Container Templates in Proxmox
link to video:  [LearnLinuxTV](https://www.youtube.com/watch?v=J29onrRqE_I&list=PLT98CRl2KxKHnlbYhtABg6cF50bYa8Ulo&index=9)
## Introduction
This guide will show you how to create templates for your containers in Proxmox. Creating templates can save you time when deploying multiple containers with similar configurations.

## Steps

### 1. Update the Container
- Ensure your container is fully updated by running the following commands:

```bash
sudo apt update && sudo apt dist-upgrade
```

### 2. Clean Up
- Clean the apt package database:

```bash
sudo apt clean
```

- Remove orphan packages:

```bash
sudo apt autoremove
```

### 3. Delete SSH Host Keys
- Go to the `/etc/ssh` directory:

```bash
cd /etc/ssh
```

- Remove the host keys:

```bash
sudo rm ssh_host_*
```

**Note**: Do not disconnect the SSH session at this point.

### 4. Clear Machine ID
- Check the machine ID:

```bash
cat /etc/machine-id
```

- Clear the machine ID:

```bash
sudo truncate -s 0 /etc/machine-id
```

### 5. Shut Down the Container
- Run the following command:

```bash
sudo poweroff
```

### 6. Convert the Container to a Template
- In the Proxmox GUI, right-click on the container and select "Convert to Template".

### 7. Clone the Template
- Right-click on the template and click "Clone".
- Configure the clone settings as needed and create the new container.

### 8. Reset SSH Host Keys Manually
- SSH into the newly created container.
- Remove the existing host keys:

```bash
sudo rm /etc/ssh/ssh_host_*
```

- Regenerate the host keys:

```bash
sudo dpkg-reconfigure openssh-server
```

**Note**: Repeat this process for each container created from the template.

## Conclusion
You have now successfully created a container template in Proxmox and deployed containers from it. By following these steps, you can efficiently deploy multiple containers with similar configurations.
