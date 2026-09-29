#!/bin/bash

echo "=================================================="
echo "Starting Final Production Configuration (Part B - Point 6)"
echo "=================================================="

# 1. Ensure persistent volume directories for mail and data exist with proper permissions
echo "Setting up persistent directories and permissions..."
mkdir -p mail-data/mail-state mail-data/mail-config
chmod -R 755 mail-data/

# 2. Check for the existence of the environment configuration file (.env)
if [ ! -f .env ]; then
    if [ -f .env.example ]; then
        cp .env.example .env
        echo "[INFO] Created .env file from .env.example. Please update your secrets!"
    else
        echo "[WARNING] .env.example not found. Make sure your environment variables are set."
    fi
fi

# 3. Validate HAProxy configuration syntax before container startup
if command -v haproxy &> /dev/null; then
    haproxy -c -f proxy/haproxy/haproxy.cfg
    if [ $? -eq 0 ]; then
        echo "[SUCCESS] HAProxy configuration syntax is valid."
    else
        echo "[ERROR] HAProxy configuration syntax is invalid!"
        exit 1
    fi
fi

# 4. Build and run all services via Docker Compose
echo "Launching production stack with Docker Compose..."
docker compose down
docker compose up --build -d

echo "=================================================="
echo "[SUCCESS] All Part A and Part B configurations deployed!"
echo "Check running containers using: docker compose ps"
echo "=================================================="