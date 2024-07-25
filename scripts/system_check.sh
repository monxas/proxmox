#!/bin/bash

# Check for updates
check_updates() {
  echo "Checking for updates..."
  if apt-get update && apt-get -s upgrade | grep -q '0 upgraded'; then
    updates_available=false
    echo "System is up to date."
  else
    updates_available=true
    echo "Updates are available."
  fi
}

# Check if SSH is installed and running
check_ssh() {
  echo "Checking SSH status..."
  if command -v ssh >/dev/null 2>&1 && systemctl is-active --quiet ssh; then
    ssh_installed=true
    echo "SSH is installed and running."
  else
    ssh_installed=false
    echo "SSH is not installed or not running."
  fi
}

# Check if user 'monxas' exists
check_user() {
  echo "Checking for user 'monxas'..."
  if id "monxas" &>/dev/null; then
    user_exists=true
    echo "User 'monxas' exists."
  else
    user_exists=false
    echo "User 'monxas' does not exist."
  fi
}

# Check for free unallocated disk space
check_disk_space() {
  echo "Checking for free unallocated disk space..."
  free_space=$(df -h --output=avail / | tail -1 | awk '{$1=$1};1')
  echo "Free disk space: $free_space"
}

# Check if Docker is installed
check_docker() {
  echo "Checking Docker status..."
  if command -v docker >/dev/null 2>&1; then
    docker_installed=true
    echo "Docker is installed."
  else
    docker_installed=false
    echo "Docker is not installed."
  fi
}

# Run checks and present report
run_checks() {
  check_updates
  check_ssh
  check_user
  check_disk_space
  check_docker
}

# Menu options
menu_options() {
  echo "1. Install updates"
  echo "2. Install and start SSH"
  echo "3. Create user 'monxas'"
  echo "4. Allocate free disk space"
  echo "5. Install Docker"
  echo "6. Exit"
}

# Install updates
install_updates() {
  echo "Installing updates..."
  sudo apt-get upgrade -y
}

# Install and start SSH
install_ssh() {
  echo "Installing SSH..."
  sudo apt-get install openssh-server -y
  sudo systemctl start ssh
  sudo systemctl enable ssh
}

# Create user 'monxas'
create_user() {
  echo "Creating user 'monxas'..."
  sudo adduser monxas
  sudo usermod -aG sudo monxas
}

# Allocate free disk space
allocate_disk_space() {
  echo "Checking if cloud-guest-utils is installed..."
  if ! dpkg -l | grep -q cloud-guest-utils; then
    echo "Installing cloud-guest-utils..."
    sudo apt-get update
    sudo apt-get install cloud-guest-utils -y
  fi

  echo "Allocating free disk space..."
  sudo growpart /dev/sda 1
  sudo resize2fs /dev/sda1
}

# Install Docker
install_docker() {
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com -o install-docker.sh
  cat install-docker.sh
  sh install-docker.sh --dry-run
  sudo sh install-docker.sh
}

# Main script
main() {
  run_checks

  echo "System Report:"
  echo "-----------------"
  echo "Updates available: $updates_available"
  echo "SSH installed and running: $ssh_installed"
  echo "User 'monxas' exists: $user_exists"
  echo "Free disk space: $free_space"
  echo "Docker installed: $docker_installed"
  echo "-----------------"

  while true; do
    menu_options
    read -p "Choose an option: " option
    case $option in
      1)
        if [ "$updates_available" = true ]; then
          install_updates
        else
          echo "No updates available."
        fi
        ;;
      2)
        if [ "$ssh_installed" = false ]; then
          install_ssh
        else
          echo "SSH is already installed and running."
        fi
        ;;
      3)
        if [ "$user_exists" = false ]; then
          create_user
        else
          echo "User 'monxas' already exists."
        fi
        ;;
      4)
        allocate_disk_space
        ;;
      5)
        if [ "$docker_installed" = false ]; then
          install_docker
        else
          echo "Docker is already installed."
        fi
        ;;
      6)
        echo "Exiting..."
        break
        ;;
      *)
        echo "Invalid option. Please try again."
        ;;
    esac
  done
}

main
