#!/bin/bash

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

# Install K3s (Server Mode)
echo "🚀 Installing K3s..."
curl -sfL https://get.k3s.io | sh -

# Verify K3s installation
echo "✅ Checking K3s status..."
sudo systemctl status k3s --no-pager

# Enable K3s on startup
echo "🔄 Enabling K3s service..."
sudo systemctl enable k3s

# Configure kubectl for the current user
echo "🔧 Setting up K3s kubectl..."
mkdir -p $HOME/.kube
sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config
echo 'export KUBECONFIG=$HOME/.kube/config' >> ~/.bashrc

# Print K3s node status
echo "📌 Checking K3s nodes..."
kubectl get nodes

echo "🎉 K3s Installation Complete!"
