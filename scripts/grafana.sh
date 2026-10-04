#!/bin/bash
set -e

echo "Installing Grafana natively as a system service..."
# Install prerequisites for official Grafana repository
sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/

# Add Grafana GPG key and repository
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

# Install Grafana server package
sudo apt-get update -y
sudo apt-get install -y grafana

# Enable and start the native Grafana service
sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

echo "📊 Grafana installed natively! Dashboards so gorgeous they belong in a museum."