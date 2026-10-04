#!/bin/bash
set -e

echo "Installing AWS CLI v2, kubectl, and eksctl..."
# Download the official AWS CLI v2 installation package zip file
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the installer package
unzip awscliv2.zip

# Run the official AWS installer script
sudo ./aws/install

# Clean up downloaded archive and temporary files
rm -rf awscliv2.zip aws

# Download the latest stable release of kubectl for managing Kubernetes clusters
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Make kubectl executable and move it to the system path
sudo chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Set architecture variables for downloading eksctl
ARCH=amd64
PLATFORM=$(uname)_$ARCH

# Download and extract the latest eksctl release archive directly into local bin
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

echo "☁️ AWS, kubectl & eksctl ready! You are now legally certified to talk about the cloud."