#!/bin/bash


# Set architecture variables for downloading eksctl
ARCH=amd64
PLATFORM=$(uname)_$ARCH

# Download and extract the latest eksctl release archive directly into local bin
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

echo "☁️ AWS, kubectl & eksctl ready! You are now legally certified to talk about the cloud."
