# Migration Guide: Part C (Modernizing Stack to Django 5 & Psycopg 3)

This document outlines the architectural updates and package upgrades implemented to fulfill **Part C** of the project requirements, ensuring modern performance standards, robust connection pooling, and full compatibility with Django 5.

## Summary of Upgrades

1. **Psycopg Driver Upgrade (`psycopg2` -> `psycopg3`):** Migrated from the legacy `psycopg2` driver to the modern, high-performance `psycopg` (v3) library.
2. **Connection Pooling (`psycopg-pool`):** Integrated native `psycopg-pool` support to handle database connection concurrency efficiently.
3. **Framework Upgrade (`Django 4.x` -> `5.x`):** Upgraded the core backend framework to Django 5, leveraging modern asynchronous capabilities, enhanced type hints, and improved performance.

---

## Technical Details & Configuration

### 1. Dependency Specifications (`backend/requirements.txt`)

The core dependencies have been explicitly pinned to support Django 5 and the modern Psycopg 3 ecosystem:

```text
Django>=5.0,<5.1
psycopg[binary]>=3.1.18
psycopg-pool>=3.2.1
django-environ>=0.11.2
gunicorn>=22.0.0
```

### 2. Django Database Engine Alignment (core/settings.py)In Django 5, the standard PostgreSQL backend natively detects and utilizes the modern psycopg (v3) driver when installed in the environment:

```python
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "dbname",
        "USER": "user",
        "PASSWORD": "password",
        "HOST": "postgres",
        "PORT": "5432",
    }
}
```

## Verification & Testing

To verify that the modern backend stack is running properly inside the container environment:

### 1. Build and launch the container stack using Docker Compose:

```bash
docker compose up --build -d
```

### 2. Check container logs to ensure Django 5 starts cleanly without database driver errors:

```bash
docker compose logs web
```
