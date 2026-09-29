# Server Firewall & Security Configuration

This directory contains the production-grade kernel-level firewall configuration using `nftables` and an automated deployment script for Linux/Linode servers.

## Features

- **Kernel-Level Filtering:** Utilizes `nftables` for efficient packet filtering with a default-drop policy.
- **Threat Intelligence Integration:** Features a dynamic `blacklisted_ips` set leveraging the `ipset` framework to instantly drop packets from malicious IP addresses.
- **Granular Inbound Rules:**
  - **SSH (Port 22):** Restricted to a specific admin IP address with strict rate-limiting (10 connections/second, burst 20).
  - **HTTP/HTTPS (Ports 80, 443):** Protected by per-IP new connection rate-limiting to mitigate flooding and brute-force attempts.
  - **Mail Stack (Ports 25, 465, 587, 993):** Fully supports inbound SMTP, SMTPS, Submission, and secure IMAPS (Dovecot) traffic.
  - **ICMP:** Allowed with controlled rate-limiting to prevent ping floods.
- **Strict Outbound Filtering:** Enforces a default-drop policy on outbound traffic, allowing only essential ports and protocols (DNS, Mail, HTTP/HTTPS, NTP, and ICMP).

---

## Files Overview

- `security/nftables.conf`: The main firewall ruleset configuration file.
- `deploy-firewall.sh`: An automated deployment script to upload, validate, and activate the firewall rules on a remote server via SSH.

---

## Usage / Deployment Instructions

### 1. Configure the Deployment Script

Open `deploy-firewall.sh` and update the connection variables to match your remote server details:

```bash
REMOTE_USER="root"
REMOTE_HOST="YOUR_SERVER_IP"  # Replace with your Linode public IP
REMOTE_PORT="22"                 # Change if using a custom SSH port
```

### 2. Update Admin IP in the Ruleset

Open `security/nftables.conf` and replace `<YOUR_IP>` in the SSH rule section with your actual static administrative IP address:

```bash
ip saddr YOUR_STATIC_IP tcp dport 22 limit rate 10/second burst 20 packets accept comment "Allow SSH only from admin IP"
```

### 3. Grant Execution Permission

Make the deployment script executable from your local terminal:

```bash
chmod +x deploy-firewall.sh
```

### 4. Execute the Deployment

Run the script to automatically upload the configuration, check syntax validity, install `nftables` if missing, and restart the firewall service on your remote host:

```bash
./deploy-firewall.sh
```
