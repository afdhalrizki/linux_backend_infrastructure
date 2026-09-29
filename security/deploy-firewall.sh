#!/bin/bash

# Linode Server Access Configuration
# Adjust the variables below with your server's IP and user
REMOTE_USER="root"
REMOTE_HOST="192.0.2.1"          # Replace with your Linode public IP
REMOTE_PORT="22"                 # SSH Port (if still default)
LOCAL_FILE="security/nftables.conf"
REMOTE_PATH="/etc/nftables.conf"

echo "=================================================="
echo "Uploading nftables configuration to Linode server..."
echo "=================================================="

# 1. Copy file using SCP
scp -P "$REMOTE_PORT" "$LOCAL_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

if [ $? -eq 0 ]; then
    echo "[SUCCESS] File successfully copied to $REMOTE_HOST:$REMOTE_PATH"
    
    echo "=================================================="
    echo "Applying firewall rules on the server..."
    echo "=================================================="
    
    # 2. Execute remote commands to enable nftables
    ssh -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" << 'EOF'
        # Ensure nftables is installed
        if ! command -v nft &> /dev/null; then
            echo "Installing nftables..."
            apt-get update && apt-get install -y nftables
        fi

        # Validate configuration file syntax
        nft -c -f /etc/nftables.conf
        if [ $? -eq 0 ]; then
            echo "nftables syntax is valid. Enabling service..."
            systemctl enable nftables
            systemctl restart nftables
            echo "[SUCCESS] nftables firewall successfully started!"
        else
            echo "[FAILED] nftables syntax is invalid, please check your configuration file."
            exit 1
        fi
EOF
else
    echo "[FAILED] Failed to copy file to the server. Please check your connection or SSH credentials."
    exit 1
fi