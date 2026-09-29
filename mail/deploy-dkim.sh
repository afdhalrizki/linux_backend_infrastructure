#!/bin/bash

echo "=================================================="
echo "Installing and Configuring OpenDKIM for Postfix..."
echo "=================================================="

# 1. Install opendkim and opendkim-tools
apt-get update && apt-get install -y opendkim opendkim-tools

# 2. Create directory for DKIM keys
mkdir -p /etc/opendkim/keys/yourdomain.com

# 3. Generate DKIM private and public keys
opendkim-genkey -b 2048 -s default -d yourdomain.com -D /etc/opendkim/keys/yourdomain.com/
chown -R opendkim:opendkim /etc/opendkim
chmod 700 /etc/opendkim/keys
chmod 600 /etc/opendkim/keys/yourdomain.com/default.private

# 4. Configure /etc/opendkim.conf
cat << 'EOF' > /etc/opendkim.conf
AutoRestart             Yes
AutoRestartRate         10/1h
Umask                   002
Syslog                  yes
SyslogSuccess           Yes
LogWhy                  yes
Canonicalization        relaxed/simple
Mode                    sv
SubDomains              no
KeyTable                refile:/etc/opendkim/KeyTable
SigningTable            refile:/etc/opendkim/SigningTable
ExternalIgnoreList      refile:/etc/opendkim/TrustedHosts
InternalHosts           refile:/etc/opendkim/TrustedHosts
Socket                  inet:8891@localhost
PidFile                 /var/run/opendkim/opendkim.pid
UserID                  opendkim:opendkim
TemporaryFailureRetry   yes
EOF

# 5. Configure mapping files
echo "default._domainkey.yourdomain.com yourdomain.com:default:/etc/opendkim/keys/yourdomain.com/default.private" > /etc/opendkim/KeyTable
echo "*@yourdomain.com default._domainkey.yourdomain.com" > /etc/opendkim/SigningTable

cat << 'EOF' > /etc/opendkim/TrustedHosts
127.0.0.1
localhost
192.0.2.0/24
.yourdomain.com
EOF

# 6. Restart services
systemctl enable opendkim
systemctl restart opendkim
systemctl restart postfix

echo "[SUCCESS] OpenDKIM is configured and integrated with Postfix!"
echo "IMPORTANT: Please add the following public DKIM key to your DNS records:"
cat /etc/opendkim/keys/yourdomain.com/default.txt