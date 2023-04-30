#!/bin/bash
# to run:
# curl -sSL https://github.com/monxas/proxmox/blob/develop/scripts/post-clone-ubuntu.sh | sudo bash
# Function to check if the command executed successfully
check_command() {
  if [ $? -ne 0 ]; then
    echo "Error: $1"
    exit 1
  fi
}

# Ask for the new hostname
while true; do
  echo "Enter the new hostname:"
  read new_hostname

  if [ -n "$new_hostname" ]; then
    break
  else
    echo "Hostname cannot be empty. Please enter a valid hostname."
  fi
done

# Change hostname
echo "Changing hostname..."
sudo hostnamectl set-hostname "$new_hostname"
check_command "Failed to set hostname."

echo "$new_hostname" | sudo tee /etc/hostname >/dev/null
sudo sed -i "s/127.0.1.1.*/127.0.1.1 $new_hostname/g" /etc/hosts
check_command "Failed to update /etc/hosts."

# Regenerate SSH keys
echo "Regenerating SSH keys..."
sudo rm -f /etc/ssh/ssh_host_*
sudo dpkg-reconfigure openssh-server
check_command "Failed to regenerate SSH keys."

# Update package sources and upgrade
echo "Updating package sources and upgrading..."
sudo apt update
check_command "Failed to update package sources."

sudo apt upgrade -y
check_command "Failed to upgrade packages."

# Reset passwords
while true; do
  echo "Do you want to reset the current user password? (y/n)"
  read reset_password

  if [[ "$reset_password" =~ ^[yYnN]$ ]]; then
    break
  else
    echo "Invalid input. Please enter 'y' or 'n'."
  fi
done

if [[ "$reset_password" =~ ^[yY]$ ]]; then
  echo "Resetting current user password..."
  passwd
  check_command "Failed to reset password."
fi

# Add new users
while true; do
  echo "Do you want to add a new user? (y/n)"
  read add_user

  if [[ "$add_user" =~ ^[yYnN]$ ]]; then
    if [[ "$add_user" =~ ^[yY]$ ]]; then
      while true; do
        echo "Enter the new username:"
        read username

        if [ -n "$username" ]; then
          break
        else
          echo "Username cannot be empty. Please enter a valid username."
        fi
      done

      sudo adduser "$username"
      check_command "Failed to create new user."
    else
      break
    fi
  else
    echo "Invalid input. Please enter 'y' or 'n'."
  fi
done

echo "Configuration complete!"
