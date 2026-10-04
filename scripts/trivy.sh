#!/bin/bash
set -e

echo "Installing Trivy..."
# Add Aqua Security GPG key and repository for Trivy scanner
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/trivy.gpg > /dev/null
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list

# Install Trivy
sudo apt-get update -y
sudo apt-get install -y trivy

echo "🔍 Trivy installed! Finding vulnerabilities before hackers do (hopefully)."