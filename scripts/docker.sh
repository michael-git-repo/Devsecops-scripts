#!/bin/bash
set -e

echo "Installing Docker..."
# Clean up any legacy docker installations
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true
sudo mkdir -p /etc/apt/keyrings

# Add Docker's official GPG key securely
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Setup the official Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker engine and plugins
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Grant current user permissions to run docker without sudo
sudo usermod -aG docker $USER

echo "🐋 Docker is ready! Because shipping containers isn't just for cargo ships anymore."