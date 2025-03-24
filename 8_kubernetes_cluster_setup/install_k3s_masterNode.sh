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

# Install K3s Server
echo "🚀 Installing K3s Server..."
curl -sfL https://get.k3s.io | sh -s - server --tls-san $(curl -s ifconfig.me)

# Enable K3s service
echo "🔄 Enabling K3s service..."
sudo systemctl enable k3s

# Get Token for Worker Nodes
echo "🔑 Fetching Token for Worker Nodes..."
sudo cat /var/lib/rancher/k3s/server/node-token

# Configure kubectl for the current user
echo "🔧 Setting up K3s kubectl..."
mkdir -p $HOME/.kube
sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config
echo 'export KUBECONFIG=$HOME/.kube/config' >> ~/.bashrc

# Print Node Status
echo "📌 Checking K3s nodes..."
kubectl get nodes

echo "🎉 K3s Master Node Setup Complete!"
echo "🚀 Use the token above to connect worker nodes!"
