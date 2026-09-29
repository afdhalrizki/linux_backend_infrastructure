```text
linux-django-infrastructure/
│
├── .env.example                # Template environment variables (secret keys, DB credentials)
├── docker-compose.yml          # Main orchestration file for all services
│
├── proxy/                      # Edge & Proxy Layer Configuration (Part A)
│   ├── haproxy/
│   │   └── haproxy.cfg         # HAProxy configuration (SSL Termination & Edge Routing)
│   └── traefik/
│       └── traefik.yml         # Traefik configuration as Dynamic Reverse Proxy
│
├── backend/                    # Django 5 Application (Part B)
│   ├── Dockerfile              # Custom Dockerfile for Django 5 + psycopg3
│   ├── requirements.txt        # Package dependencies (Django 5, psycopg[binary], psycopg-pool, etc.)
│   └── app/                    # Django project source code
│
├── security/                   # Firewall & Linux Hardening Configuration (Part A)
│   ├── nftables.conf           # Draft rules for nftables & ipset
│   └── fail2ban/
│       └── jail.local          # Fail2ban configuration for SSH & Mail
│
└── mail/                       # Mail Server Configuration (Part C)
    ├── postfix/
    │   └── main.cf             # Postfix configuration draft
    └── dovecot/
        └── dovecot.conf        # Dovecot configuration draft
```
# linux_backend_infrastructure
