# Final Deployment & Configuration Guide (Part B - Point 6)

This document provides instructions for the automated final deployment script (`deploy-final.sh`) designed to assemble, validate, and launch the complete production stack (Part A and Part B) on your Linode server.

## Overview

The `deploy-final.sh` script automates the final operational steps required to bring the entire monorepo architecture online. It handles:

1. **Persistent Directory Initialization:** Automatically creates required state and configuration directories for mail volumes with proper file permissions.
2. **Environment Configuration Check:** Ensures an active `.env` configuration file exists based on `.env.example`.
3. **HAProxy Syntax Validation:** Verifies the configuration file syntax before spinning up proxy services to prevent runtime boot failures.
4. **Docker Compose Orchestration:** Rebuilds and launches all containerized services (HAProxy, Traefik, Nginx Mail Proxy, PostgreSQL, Django Backend, and Mailserver) in background daemon mode.

---

## Instructions for Execution

### 1. Prerequisites

Ensure you have administrative privileges, Docker, Docker Compose, and HAProxy installed on your target Linux/Linode host server. Make sure your SSL certificate bundle (`combined_domain.pem`) is placed in the designated path specified in your HAProxy configuration.

### 2. Grant Execution Permission

Before running the script for the first time, make it executable from your terminal:

```bash
chmod +x deploy-final.sh
```

### 3. Execute the Deployment Script

Run the script to start the final orchestration and validation sequence:

```bash
./deploy-final.sh
```

### 4. Verification

After the script completes successfully, verify that all containers are running properly by executing:

```bash
docker compose ps
```
