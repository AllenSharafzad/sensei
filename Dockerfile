# SENSEI - End-to-End Testing for Chatbots
FROM python:3.11-slim

LABEL maintainer="SENSEI Project"
LABEL description="SENSEI: End-to-end testing framework for chatbots"

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir taskyto python-dotenv

# Copy application code
COPY src/ ./src/
COPY examples/ ./examples/
COPY personalities/ ./personalities/

# Create directories for output
RUN mkdir -p /app/test_cases /app/rules

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Default command shows help
CMD ["python", "src/sensei-chat.py", "--help"]
