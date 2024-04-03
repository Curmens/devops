#!/bin/bash

# Get username from user input
read -p "Enter desired username for deploy user: " username

# Check if username is empty
if [ -z "$username" ]; then
  echo "Error: Username cannot be empty!"
  exit 1
fi

# Get SSH public key from user input
read -p "Enter your SSH public key: " pubkey

# Check if public key is empty
if [ -z "$pubkey" ]; then
  echo "Error: SSH public key cannot be empty!"
  exit 1
fi

# Create the deploy user
sudo adduser "$username"

# Check for successful user creation
if [ $? -ne 0 ]; then
  echo "Error: Failed to create user!"
  exit 1
fi

# Add user to sudo group
sudo usermod -aG sudo "$username"

# Create the .ssh directory for the deploy user
sudo mkdir /home/"$username"/.ssh

# Change ownership of the .ssh directory to the deploy user
sudo chown -R "$username":"$username" /home/"$username"/.ssh

# Add the provided SSH public key to authorized_keys
echo "$pubkey" | sudo tee /home/"$username"/.ssh/authorized_keys > /dev/null

# Set permissions for .ssh directory and authorized_keys file
sudo chown -R "$username":"$username" /home/"$username"/.ssh  # Change ownership to the deploy user
sudo chmod 700 /home/"$username"/.ssh
sudo chmod 600 /home/"$username"/.ssh/authorized_keys

# Disable password authentication in SSH configuration (optional)
# Uncomment the following lines to disable password authentication
#
# sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
# sudo service ssh restart

echo "Deploy user '$username' created successfully!"

