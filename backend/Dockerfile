# Use the official stable Python slim image
FROM python:3.11-slim

# Set environment variables to prevent Python from writing pyc files and to buffer logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies required for compiling Python packages if needed
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies first (to maximize Docker Layer Caching)
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire django-project folder contents into the container working directory (/app)
COPY django-project/ .

# Expose the Django application port
EXPOSE 8000

# Default command to run the server using Gunicorn (pointing to core.wsgi)
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "core.wsgi:application"]