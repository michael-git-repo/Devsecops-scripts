#!/bin/bash

set -e

echo "=========================================="
echo "📊 INSTALLING NODE EXPORTER"
echo "=========================================="

sudo apt update -y

VERSION="1.9.1"

echo "📦 Downloading Node Exporter..."

wget -q \
"https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/node_exporter-${VERSION}.linux-amd64.tar.gz"

tar xvf node_exporter-${VERSION}.linux-amd64.tar.gz

sudo cp \
node_exporter-${VERSION}.linux-amd64/node_exporter \
/usr/local/bin/

sudo useradd \
--no-create-home \
--shell /bin/false \
node_exporter 2>/dev/null || true

sudo chown node_exporter:node_exporter \
/usr/local/bin/node_exporter

echo "⚙️ Creating Node Exporter service..."

sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl restart node_exporter

rm -rf node_exporter-${VERSION}.linux-amd64
rm -f node_exporter-${VERSION}.linux-amd64.tar.gz

echo ""
echo "=========================================="
echo "🎉 NODE EXPORTER INSTALLED"
echo "=========================================="
echo "📊 Port: 9100"
echo "✅ Service: RUNNING"
echo "=========================================="

sudo systemctl --no-pager status node_exporter
