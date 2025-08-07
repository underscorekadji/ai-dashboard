#!/bin/bash

# AI Dashboard - Restart Script
# Restarts the Glance dashboard by stopping and starting services

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Restarting AI Dashboard..."

# Stop services
echo "⏹️ Stopping services..."
"$SCRIPT_DIR/stop.sh"

# Start services
echo "▶️ Starting services..."
"$SCRIPT_DIR/start.sh"

echo "✅ Dashboard restart complete!"