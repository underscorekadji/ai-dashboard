# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an AI Tools Monitoring Dashboard built using the Glance application. It's a containerized personal dashboard that aggregates various information sources including RSS feeds, weather, markets, GitHub releases, and social media feeds.

## Architecture

The project consists of:

- **Glance Dashboard**: Main dashboard service running in Docker
- **Configuration**: YAML-based configuration in `config/glance.yml`
- **Container Orchestration**: Docker Compose for service management
- **Scripts**: Shell scripts for start/stop operations

## Development Commands

### Starting the Dashboard

```bash
./scripts/start.sh
```

This script will:

- Create `.env` from `.env.example` if it doesn't exist
- Check Docker status
- Pull latest images
- Start services via docker-compose
- Verify service health

### Stopping the Dashboard

```bash
./scripts/stop.sh
```

### Manual Docker Operations

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs glance

# View real-time logs
docker-compose logs -f glance

# Check service status
docker-compose ps
```

## Configuration

### Main Dashboard Configuration

- File: `config/glance.yml`
- Contains widget definitions, RSS feeds, API endpoints, and dashboard layout
- Uses 3-column layout: small (left), full (center), small (right)
- Widgets include: calendar, RSS feeds, Twitch channels, Hacker News, weather, markets, GitHub releases

### Environment Variables

- File: `.env` (created from `.env.example`)
- `GLANCE_PORT`: Dashboard port (default: 8080)
- `GLANCE_HOST`: Host binding (default: 0.0.0.0)

## Service Access

- Dashboard URL: <http://localhost:8080>
- Container name: `ai-dashboard-glance`
- Health check: Built-in HTTP health monitoring

## File Structure

- `docker-compose.yml`: Service definitions and networking
- `config/glance.yml`: Dashboard configuration
- `scripts/`: Start/stop automation scripts
- `assets/`: Custom CSS styling
- `docs/`: Documentation and resources
- `.env.example`: Environment variable template

## Official Documentation

### Glance Documentation

- **Official Repository**: [glanceapp/glance](https://github.com/glanceapp/glance)
- **Configuration Reference**: Use for widget configuration, API settings, and dashboard customization
- **Widget Types**: Reference for available widgets and their configuration options

### When to Use Official Documentation

- **Adding new widgets**: Consult the official docs for widget types and configuration syntax
- **API integrations**: Check documentation for RSS feeds, weather APIs, market data sources
- **Troubleshooting**: Official issues and discussions for common problems
- **Configuration validation**: Verify YAML syntax and available options
- **Updates**: Check for new features and breaking changes

## Notes

- The dashboard runs as a containerized service with persistent data volume
- Configuration is mounted read-only from the host
- Optional Nginx reverse proxy configuration is available but commented out
- Health checks ensure service reliability
