# Multi-stage containerized build for FastMCP Sorceress service
FROM python:3.11-slim as builder

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Final runtime image
FROM python:3.11-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    ENVIRONMENT=production \
    PYTHONPATH=/app

COPY --from=builder /install /usr/local
COPY . .

# Ensure logs directory exists
RUN mkdir -p logs

EXPOSE 8848

# Healthcheck endpoint (streamable-http root/tools)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8848/mcp', timeout=3)" || exit 1

ENTRYPOINT ["fastmcp", "run", "server.py", "--transport", "http", "--host", "0.0.0.0", "--port", "8848"]
