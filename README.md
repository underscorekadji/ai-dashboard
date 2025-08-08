# AI Tools Monitoring Dashboard

Containerized personal dashboard built with Glance. It aggregates GitHub Copilot news, status, videos, blog posts, and handy links into a single page, with health checks, persistent data, and one-liner scripts to run locally via Docker.

## Features

- Glance dashboard preconfigured for GitHub Copilot resources (status, RSS, YouTube playlist, Reddit, bookmarks)
- Docker Compose with healthcheck, persistent volume, and simple networking
- Start/stop/restart scripts that bootstrap .env automatically
- Configuration-first setup using YAML in `config/`

## Prerequisites

- Docker Desktop (includes Docker Compose v2)
- macOS, Linux, or Windows with WSL2

## Quick start

1. Create your environment file (optional; script will create it for you):

```bash
cp .env.example .env
```

2. Start the dashboard:

```bash
./scripts/start.sh
```

3. Open the UI:

- [http://localhost:8080](http://localhost:8080) (default)

4. Stop or restart when needed:

```bash
./scripts/stop.sh
./scripts/restart.sh
```

## Configuration

- Main entrypoint: `config/glance.yml`
  - Includes `config/gh-copilot.yml` which defines the Copilot-focused page: status widget, bookmarks, RSS feeds, YouTube playlist, subreddit, and a repository panel.
- Ports and host binding are controlled via `.env`:

```properties
# .env
GLANCE_PORT=8080
GLANCE_HOST=0.0.0.0
```

- Docker Compose mounts `./config` into the container read-only and persists data in the `glance_data` volume.

If you want to customize or add more pages/widgets, edit the YAML files in `config/` and restart the stack.

## Project structure

```text
.
├── assets/
│   └── custom.css              # (optional) place for styling; not mounted by default
├── config/
│   ├── glance.yml              # main Glance configuration (includes gh-copilot.yml)
│   └── gh-copilot.yml          # Copilot-specific widgets and layout
├── docs/
│   └── GitHub_Copilot.md       # curated Copilot resources
├── scripts/
│   ├── start.sh                # creates .env (if missing), pulls images, and starts services
│   ├── stop.sh                 # stops services
│   └── restart.sh              # stop + start
├── docker-compose.yml          # Glance service, healthcheck, volume and network
├── .env.example                # default environment variables
└── README.md
```

## Service details

- Image: `glanceapp/glance:latest`
- Container: `ai-dashboard-glance`
- Port mapping: `${GLANCE_PORT:-8080}:8080`
- Healthcheck: HTTP check on `http://localhost:8080`
- Data persistence: `glance_data` Docker volume

## Reverse proxy (optional)

An example Nginx service is scaffolded (commented) in `docker-compose.yml` for SSL termination. To use it, add your `nginx.conf` and certificates, then uncomment the service and volumes.

## Maintenance

- Update to the latest image:

```bash
docker-compose pull
./scripts/restart.sh
```

- View logs:

```bash
docker-compose logs -f glance
```

## Troubleshooting

- Docker isn’t running: start Docker Desktop and retry.
- Port already in use: change `GLANCE_PORT` in `.env`, then restart.
- Blank page or config errors: validate YAML in `config/` and check logs with `docker compose logs glance`.
  
 Use: `docker-compose logs glance` if you’re following the scripts in this repo.

## References

- Glance project: <https://github.com/glanceapp/glance>
