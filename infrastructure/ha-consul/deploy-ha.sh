#!/bin/bash

echo "=================================================="
echo "Installing Keepalived and Consul dependencies..."
echo "=================================================="

# 1. Update system and install keepalived
apt-get update && apt-get install -y keepalived curl gpg lsb-release

# 2. Install HashiCorp Consul (official HashiCorp repository)
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt-get update && apt-get install -y consul

echo "=================================================="
echo "Configuring services..."
echo "=================================================="

# Copy Keepalived configuration (assuming execution on the Master node)
cp keepalived-master.conf /etc/keepalived/keepalived.conf

# Copy Consul configuration
cp consul-server.hcl /etc/consul.d/consul.hcl

# Enable and start services
systemctl enable keepalived
systemctl restart keepalived

systemctl enable consul
systemctl restart consul

echo "[SUCCESS] Keepalived and Consul are successfully deployed and running!"