## AI agent guide for this repo (ai-dashboard)

Purpose: a containerized Glance dashboard focused on GitHub Copilot resources. It’s config-first (YAML), runs via Docker Compose, and is managed with helper scripts.

### Architecture & key files

- Single service: glanceapp/glance (container name: ai-dashboard-glance) in `docker-compose.yml`
- Config (read-only) mounted to container: `./config -> /app/config`; data in Docker volume `glance_data`
- Main entrypoint: `config/glance.yml` includes pages via `$include` instruction.
- Copilot page: `config/gh-copilot.yml` (widgets & layout)
- Scripts: `scripts/start.sh`, `scripts/stop.sh`, `scripts/restart.sh`
- Env: `.env` (auto-created from `.env.example`). Key vars: `GLANCE_PORT` (8080), `GLANCE_HOST` (0.0.0.0)

### Run & dev workflow

- Preferred scripts (keep in sync with docs):
  - Start: `./scripts/start.sh` (pulls images, creates .env if missing, starts, shows logs)
  - Stop: `./scripts/stop.sh`
  - Restart: `./scripts/restart.sh`
- Manual (match script style): `docker-compose up -d`, `docker-compose down`, `docker-compose logs -f glance`, `docker-compose ps`
- Loop: edit YAML in `config/` → `./scripts/restart.sh` → check `docker-compose logs glance` → open http://localhost:${GLANCE_PORT:-8080}

### Glance configuration patterns

- Compose pages with `$include` from `config/glance.yml`:
  ```yaml
  pages:
    - $include: gh-copilot.yml
  ```
- Widgets showcased in `config/gh-copilot.yml`:
  - custom-api → GitHub status JSON with a small HTML template loop
  - bookmarks → curated Copilot links (docs, training, changelog, YT, Reddit, Discord)
  - rss → GitHub Copilot changelog + AI & ML blog
  - videos → YouTube playlist id `PL0lo9MOBetEHEHi9h0k_lPn0XZdEeYZDS`
  - reddit → subreddit `GithubCopilot`
  - repository → `github/awesome-copilot`
- Example (trimmed) custom-api template used:
  ```yaml
  - type: custom-api
    url: https://eu.githubstatus.com/api/v2/components.json
    title: GitHub Services Status
    template: |
      <div>
        {{ range .JSON.Array "components" }}
          <div style="display:flex;justify-content:space-between">
            <span>{{ .String "name" }}</span>
            {{ if eq (.String "status") "operational" }}
              <span class="color-positive">● OK</span>
            {{ else }}
              <span class="color-negative">● {{ .String "status" }}</span>
            {{ end }}
          </div>
        {{ end }}
      </div>
  ```

### Docker specifics

- Port map: `${GLANCE_PORT:-8080}:8080`; healthcheck wget to `http://localhost:8080`
- Network: single `glance_network` bridge; volume: `glance_data`
- Config is read-only by design; writeable state in `glance_data`

### Conventions

- Use the scripts’ `docker-compose` (hyphen) form for consistency unless updating scripts/docs together
- Add new pages/widgets under `config/` and include from `glance.yml`; keep files small and composable
- `assets/custom.css` exists but isn’t mounted by default—only mount if you explicitly add it to Compose + config
- External integrations are public endpoints; no secrets required by default

### Troubleshooting

- Docker not running → start Docker Desktop, rerun `./scripts/start.sh`
- Port conflict → change `GLANCE_PORT` in `.env`, then `./scripts/restart.sh`
- Blank/misrendered widgets → validate YAML and check `docker-compose logs glance`

### In-repo references

- `README.md` (overview, quick start, structure)

If anything’s unclear (e.g., mounting custom CSS, adding SSL via the optional nginx service, or extending widgets), describe the change and I’ll refine these instructions.
