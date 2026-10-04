#!/bin/bash
set -e

echo "Installing Terraform and Ansible..."

# 1. Clean up any old HashiCorp key/repo files to prevent conflicts
sudo rm -f /usr/share/keyrings/hashicorp-archive-keyring.gpg /etc/apt/sources.list.d/hashicorp.list

# 2. Download and dearmor the latest HashiCorp GPG key properly
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# 3. Add the HashiCorp repository using the correct signed-by path
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

# 4. Update package list and install Terraform
sudo apt-get update -y
sudo apt-get install -y terraform

# 5. Add the official Ansible PPA and install Ansible
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible

echo "🌍 Terraform & Ansible installed! Writing infrastructure like poetry."
