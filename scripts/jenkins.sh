#!/bin/bash
set -e

echo "Installing Jenkins..."

# Install Java 21 (required by modern Jenkins versions) and font config
sudo apt-get update -y
sudo apt-get install -y fontconfig openjdk-21-jre

# Download and add the official Jenkins 2026 GPG signing key securely
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# Add the stable Jenkins apt repository to your system sources list
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package lists to include Jenkins packages
sudo apt-get update -y

# Install Jenkins
sudo apt-get install -y jenkins

# Enable and start the Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "🎩 Jenkins is up! Your automated butler is ready to build some pipelines."
