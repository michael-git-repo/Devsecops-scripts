#!/bin/bash
set -e

echo "Installing Jenkins..."
# Install Java 17 runtime which Jenkins requires
sudo apt-get install -y fontconfig openjdk-17-jre

# Add Jenkins repository GPG key and source list
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install and start Jenkins service
sudo apt-get update -y
sudo apt-get install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "🎩 Jenkins is up! Your automated butler is ready to build some pipelines."