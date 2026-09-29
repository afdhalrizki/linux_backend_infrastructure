# Architecture Migration Guide: Current to Future Stack

This document details the step-by-step procedure to transition from the legacy setup (Current Architecture) to the modern containerized infrastructure (Future Architecture).

## Migration Overview

- **Current Architecture:** Direct public entry pointing to NGINX handling both web traffic and mail services natively on the host server.
- **Future Architecture:** Edge-secured setup utilizing **HAProxy** for DDoS filtering and SSL termination at the front, **Traefik** for dynamic container web routing, **NGINX** moved to the back for mail (`postfix + dovecot`), and modernized **Django 5 / PostgreSQL** backends.

---

## Step-by-Step Implementation

### Step 1: Place Your Legacy Django Project

Move your existing Django project source files into the monorepo directory structure:

```bash
backend/django-project/
```

### Step 2: Configure Environment Variables

Copy the environment template and configure your production secrets and domain names:

```bash
cp .env.example .env
nano .env
```

### Step 3: Grant Execution Permission to the Migration Script

Make the migration script executable from your terminal:

```bash
chmod +x migrate-to-future-stack.sh
```

### Step 4: Execute the Migration Script

Run the automated script to spin up the entire containerized stack:

````
```bash
./migrate-to-future-stack.sh
````

### Step 5: Verify Deployment

Check that all services are up and running correctly:

```bash
docker compose ps
```
