#!/bin/bash

echo "=================================================================="
echo "Starting Migration: Current Architecture -> Future Architecture"
echo "=================================================================="

# 1. Validate old Django project directory structure
if [ ! -d "backend/django-project" ]; then
    echo "[ERROR] Directory 'backend/django-project' not found!"
    echo "Please ensure your legacy Django project folder is placed there."
    exit 1
fi

echo "[INFO] Preparing Future Architecture directory structures..."
mkdir -p proxy/haproxy infrastructure/nginx mail-data/mail-state mail-data/mail-config security/fail2ban

# 2. Check if Docker and Docker Compose are active
if ! command -v docker &> /dev/null; then
    echo "[ERROR] Docker is not installed. Please install Docker first."
    exit 1
fi

# 3. Clean up legacy containers if any exist
echo "[INFO] Stopping legacy containers (if running)..."
docker compose down --remove-orphans

# 4. Build and launch the new architecture stack
echo "[INFO] Building and launching the Future Architecture stack..."
echo "       - HAProxy (Edge & SSL Termination)"
echo "       - Traefik (Dynamic Web Routing)"
echo "       - NGINX (Mail Proxy at the back)"
echo "       - PostgreSQL 15 & Django 5 (Modern Backend)"
echo "       - Mailserver (Postfix + Dovecot)"

docker compose up --build -d

echo "=================================================================="
echo "[SUCCESS] Migration to Future Architecture completed successfully!"
echo "Use 'docker compose ps' to monitor the status of running services."
echo "=================================================================="