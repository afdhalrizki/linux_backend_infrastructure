#!/bin/bash

echo "=================================================="
echo "Configuring OS Kernel Protections (SYN Cookies)..."
echo "=================================================="

# Apply SYN cookies and TCP hardening parameters to prevent half-open connection floods
cat << 'EOF' > /etc/sysctl.d/99-security-hardening.conf
# Enable SYN cookies for native protection against SYN-flood attacks
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_fin_timeout = 15
EOF

# Load the new sysctl configurations immediately
sysctl --system

echo "=================================================="
echo "Installing and Starting Fail2ban..."
echo "=================================================="

# Install fail2ban if not already present
if ! command -v fail2ban-client &> /dev/null; then
    apt-get update && apt-get install -y fail2ban
fi

# Enable and restart fail2ban service to load jail.local rules
systemctl enable fail2ban
systemctl restart fail2ban

echo "[SUCCESS] Kernel security hardenings and Fail2ban are fully operational!"