#!/bin/bash
set -e
echo "Updating system packages..."
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install -y curl wget apt-transport-https gnupg lsb-release software-properties-common unzip git
echo "✅ Prerequisites installed! 🧱 Building the foundation like a true architect."