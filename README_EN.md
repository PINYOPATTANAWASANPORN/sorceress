# sorceress

A lightweight, production-ready [FastMCP](https://gofastmcp.com) service scaffold: exposes Model Context Protocol (MCP) tool capabilities over standard streamable HTTP with full-link execution tracing and middleware support.

[ [中文文档 (Chinese)](README.md) | [English Documentation](README_EN.md) ]

---

## Features

- **Standard MCP Protocol:** Exposes tools via streamable HTTP (`--transport http`).
- **Full Traceability:** Built-in `CallLogMiddleware` attaching unique `exec_id` and execution duration logging.
- **Async Lifespan:** Clean connection startup and shutdown via `httpx.init()` and `httpx.aclose()`.
- **Zero-Setup Containerization:** Includes production multi-stage `Dockerfile` and `docker-compose.yml`.
- **Client Ready:** Seamless plug-and-play with Claude Desktop, Cursor, Antigravity, and any MCP-compliant agent.

---

## Quick Start

### 1. Local Setup

```bash
# Clone the repository
git clone https://github.com/sungeer/sorceress.git
cd sorceress

# Create and activate virtual environment
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Configure environment
cp .env.example .env
```

Set `ENVIRONMENT=development` in your `.env`.

### 2. Run MCP Server

```bash
fastmcp run server.py --transport http --host 0.0.0.0 --port 8848
```

The MCP endpoint will be live at:
`http://127.0.0.1:8848/mcp`

---

## Docker Quickstart

Run with Docker in a single command:

```bash
docker compose up -d
```

Or build and run standalone:

```bash
docker build -t sorceress:latest .
docker run -d -p 8848:8848 --name sorceress -e ENVIRONMENT=production sorceress:latest
```

---

## Connecting to AI Clients

### Claude Desktop / Antigravity IDE / Cursor Config

Add the following to your `mcp_config.json`:

```json
{
  "mcpServers": {
    "sorceress": {
      "command": "fastmcp",
      "args": ["run", "server.py", "--transport", "stdio"],
      "env": {
        "ENVIRONMENT": "development"
      }
    }
  }
}
```

Or connect directly via streamable HTTP endpoint if your host client supports remote HTTP MCP:
- URL: `http://127.0.0.1:8848/mcp`

---

## Testing

Run unit and integration verification tests:

```bash
pytest tests/ -v
```

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
