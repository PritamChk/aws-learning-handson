#!/bin/bash

# Set the Master Node IP and Token (Replace with actual values)
MASTER_IP=$1 #"<MASTER_NODE_PUBLIC_IP>"
TOKEN=$2 #"<TOKEN_FROM_MASTER_NODE>"

# Detect OS
OS=$(cat /etc/os-release | grep ^ID= | cut -d= -f2 | tr -d '"')

echo "📌 Detected OS: $OS"

# Install dependencies
if [[ "$OS" == "amzn" ]]; then
    echo "🔥 Installing dependencies for Amazon Linux 2023..."
    sudo yum update -y
    sudo yum install -y curl wget iptables-services
elif [[ "$OS" == "ubuntu" ]]; then
    echo "🔥 Installing dependencies for Ubuntu..."
    sudo apt update -y
    sudo apt install -y curl wget iptables-persistent
else
    echo "❌ Unsupported OS. Exiting..."
    exit 1
fi

# Install K3s Worker Node
echo "🚀 Installing K3s Worker Node..."
curl -sfL https://get.k3s.io | K3S_URL="https://$MASTER_IP:6443" K3S_TOKEN="$TOKEN" sh -

# Enable K3s service
echo "🔄 Enabling K3s service..."
sudo systemctl enable k3s-agent

echo "🎉 K3s Worker Node Setup Complete!"
