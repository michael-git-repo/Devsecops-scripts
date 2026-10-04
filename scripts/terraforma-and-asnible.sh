#!/bin/bash
set -e

echo "Installing Terraform and Ansible..."
# Add HashiCorp repository for Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Install Terraform
sudo apt-get update -y
sudo apt-get install -y terraform

# Add Ansible PPA repository and install Ansible
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible

echo "🌍 Terraform & Ansible installed! Writing infrastructure like poetry."