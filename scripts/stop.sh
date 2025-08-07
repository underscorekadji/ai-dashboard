#!/bin/bash

# AI Dashboard Stop Script
set -e

echo "🛑 Stopping AI Dashboard..."

# Stop services
docker-compose down

echo "✅ Dashboard stopped successfully!"