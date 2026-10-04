#!/bin/bash
set -e

echo "Setting up SonarQube in isolation..."
# Increase virtual memory limit required by Elasticsearch inside SonarQube
sudo sysctl -w vm.max_map_count=524288
echo "vm.max_map_count=524288" | sudo tee -a /etc/sysctl.conf > /dev/null

# Spin up SonarQube via Docker container on port 9000
sudo docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community

echo "🛡️ SonarQube is running! Catching code smells before they ruin your day."