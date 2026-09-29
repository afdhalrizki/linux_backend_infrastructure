# Linux Backend & Infrastructure Monorepo

This repository contains the complete infrastructure overhaul, containerized architecture modernization, and security hardening scripts designed for production Linux/Linode environments. It systematically fulfills **Part A**, **Part B**, and **Part C** project requirements.

---

## 📂 Project Directory Structure

```text
linux-django-infrastructure/
├── .env.example                # Template environment variables (secret keys, DB credentials)
├── docker-compose.yml          # Main orchestration file for all production services
├── migrate-to-future-stack.sh  # Automated migration script (Current to Future Architecture)
├── deploy-final.sh             # Final production deployment and validation script
├── deploy-final.md             # Documentation for final deployment steps
├── MIGRATIONS_STEPS.md         # Step-by-step architecture transition guide
│
├── proxy/                      # Edge & Proxy Layer Configuration
│   └── haproxy/
│       ├── haproxy.cfg         # HAProxy configuration (SSL Termination & Edge Routing)
│       └── spoe-security.conf  # HAProxy SPOE configuration for advanced security
│
├── backend/                    # Django Backend Application (Part B & Part C)
│   ├── Dockerfile              # Custom Dockerfile for Django 5 + Psycopg 3
│   ├── requirements.txt        # Package dependencies (Django 5, psycopg[binary], psycopg-pool)
│   ├── B-Tee-optimization.md   # Database performance and B-Tree index guide
│   ├── MIGRATION_PART_C.md     # Stack migration guide (Django 4->5, Psycopg2->3)
│   └── django-project/         # Django project source code
│
├── security/                   # Firewall & Linux Hardening Configuration (Part A)
│   ├── nftables.conf           # Kernel-level firewall ruleset & rate-limiting
│   ├── deploy-firewall.sh      # Automated firewall deployment script via SSH
│   └── fail2ban/
│       ├── jail.local          # Fail2ban configuration for SSH, Postfix, & Dovecot
│       └── kernel-syn-cookies-&-Fail2ban-deployment.sh # OS kernel hardening script
│
├── mail/                       # Mail Server Configuration & DKIM Integration
│   ├── deploy-dkim.sh          # OpenDKIM automated installation & key generator script
│   ├── postfix/
│       └── main.cf             # Postfix configuration aligned for iCloud delivery
│   └── dovecot/
│       └── dovecot.conf        # Dovecot IMAP/POP3 configuration
│
└── mail-data/                  # Persistent volume storage for mail state and config
```

## 🚀 Architecture Summary

### Part A (Foundation & Security):

- Kernel-level firewall configuration using nftables with strict rate-limiting for SSH, HTTP/HTTPS, and Mail.
- Intrusion prevention via fail2ban jails monitoring SSH, Postfix, and Dovecot.
- High-availability primitives utilizing Keepalived and Consul.
- Postfix and OpenDKIM alignment tailored to successfully pass Apple/iCloud strict spam filters.
- PostgreSQL query diagnostics and concurrent B-Tree index optimization guidelines.

### Part B (Stack Update):

- HAProxy positioned at the edge for DDoS filtering and SSL termination.
- NGINX relocated to the back as a dedicated mail proxy in front of Postfix and Dovecot.
- Traefik deployed as a dynamic internal reverse proxy for containerized web applications.
- Advanced HAProxy SPOE & SPOA integration for real-time security offloading.

### Part C (Modern Stack Migration):

- Upgraded backend core framework to Django 5.x.
- Migrated database drivers from legacy psycopg2 to modern psycopg (v3).
- Integrated psycopg-pool for high-concurrency database connection pooling.

## ⚙️ Quick Start & Deployment

### 1. Environment Configuration

Copy the environment variable template and fill in your production credentials:

```bash
cp .env.example .env
nano .env
```

### 2. Run Automated Migration & Deployment

To migrate from a legacy setup to the modern containerized stack, grant execution permissions and run the migration script:

```bash
chmod +x migrate-to-future-stack.sh
./migrate-to-future-stack.sh
```

Alternatively, to execute the final production validation and startup sequence directly:

```bash
chmod +x deploy-final.sh
./deploy-final.sh
```

### 3. Service Verification

Verify that all containers (HAProxy, Traefik, Nginx Mail Proxy, PostgreSQL, Django Backend, and Mailserver) are running successfully:

```bash
docker compose ps
```
