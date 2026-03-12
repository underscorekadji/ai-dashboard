# AI Tools Monitoring Dashboard

Containerized personal dashboard built with [Glance](https://github.com/glanceapp/glance) that aggregates AI tools resources — news, status, videos, blog posts, and links — in a single interface via Docker.

## Features

- Multi-page dashboard: Home, GitHub Copilot, ChatGPT, Claude Code, Cursor, Local LLMs
- RSS feeds, status monitors, YouTube playlists, Reddit, bookmarks
- Dockerized with healthcheck and modular YAML config

## Prerequisites

- Docker Desktop (includes Docker Compose v2)
- macOS, Linux, or Windows with WSL2

## Quick start

1. Create your environment file:

```bash
cp .env.example .env
```

2. Pull and start the dashboard:

```bash
docker-compose pull
docker-compose up -d
```

3. Open [http://localhost:8080](http://localhost:8080)

4. Stop, restart, or view logs:

```bash
docker-compose down
docker-compose restart
docker-compose logs -f glance
```


## Configuration

Page configs in `config/`:

- `glance.yml` — main entrypoint (includes all pages)
- `index.yml` — home page
- `gh-copilot.yml` — GitHub Copilot
- `chatgpt.yml` — ChatGPT
- `claude-code.yml` — Claude Code
- `cursor.yml` — Cursor
- `local-llm.yml` — Local LLMs

Environment variables (`.env`): `GLANCE_PORT` (default `8080`), `GLANCE_HOST` (default `0.0.0.0`).

Edit YAML files in `config/` and restart the stack to apply changes.

## Local testing

Build and run the image locally:

```bash
docker-compose up -d --build
```

For live-editing config and assets without rebuilding, create an override file:

```bash
cp docker/docker-compose.override.yml.example docker/docker-compose.override.yml
```

This mounts `config/` and `assets/` as read-only volumes. After editing any YAML or CSS, restart the container to pick up changes:

```bash
docker-compose restart
```

## Troubleshooting

- **Docker isn't running** — start Docker Desktop and retry.
- **Port already in use** — change `GLANCE_PORT` in `.env`, then restart.
- **Config errors** — validate YAML in `config/` and check `docker-compose logs glance`.

## References

- Glance project: <https://github.com/glanceapp/glance>
