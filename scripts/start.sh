#!/bin/bash

# AI Dashboard Start Script
set -e

echo "🚀 Starting AI Dashboard..."

# Check if .env file exists (optional, uses defaults)
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "✅ .env file created with default settings"
fi

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Pull latest images
echo "📥 Pulling latest images..."
docker-compose pull

# Start services
echo "🔄 Starting services..."
docker-compose up -d

# Wait for services to be healthy
echo "⏳ Waiting for services to be ready..."
sleep 10

# Check if glance is running
if docker-compose ps | grep -q "Up"; then
    echo "✅ Dashboard is running!"
    echo "🌐 Access your dashboard at: http://localhost:8080"
    
    # Show logs
    echo "📋 Recent logs:"
    docker-compose logs --tail=20 glance
else
    echo "❌ Failed to start dashboard. Check logs:"
    docker-compose logs
fi