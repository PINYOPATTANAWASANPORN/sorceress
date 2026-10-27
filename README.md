# sorceress

基于 [FastMCP](https://gofastmcp.com) 的纯 MCP 服务脚手架：通过标准 MCP 协议（streamable-http）对外暴露工具能力，内置全链路日志追踪与中间件机制。

[ [中文文档 (Chinese)](README.md) | [English Documentation](README_EN.md) ]

## 快速开始

### 安装

```bash
$ git clone git@github.com:sungeer/sorceress.git
$ cd sorceress
```

创建并激活虚拟环境，安装依赖：

```bash
$ python -m venv .venv           # Windows: .venv\Scripts\activate
$ source .venv/bin/activate
$ pip install -r requirements.txt
```

配置环境变量：

```bash
$ cp .env.example .env
# 确保设置 ENVIRONMENT=development
```

### 启动

```bash
$ fastmcp run server.py --transport http --host 0.0.0.0 --port 8848
```

服务端点：`http://127.0.0.1:8848/mcp`

### Docker 容器化启动

```bash
$ docker compose up -d
```

## AI 客户端配置 (Claude Desktop / Cursor / Antigravity)

在 `mcp_config.json` 中配置：

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

## License

This project is licensed under the MIT License (see the
[LICENSE](LICENSE) file for details).
