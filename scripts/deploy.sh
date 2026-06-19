#!/bin/bash

# CONSTRUCTIQ Deployment Script
# This script deploys the CONSTRUCTIQ system to a production server

set -e

echo "🚀 Starting CONSTRUCTIQ Deployment..."

# Configuration
DEPLOY_ENV=${1:-production}
COMPOSE_FILE="docker-compose.yml"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if .env file exists
if [ ! -f .env ]; then
    log_error ".env file not found!"
    log_info "Creating .env from .env.example..."
    cp .env.example .env
    log_warn "Please configure .env file before deploying!"
    exit 1
fi

# Pull latest images
log_info "Pulling latest Docker images..."
docker-compose pull

# Stop existing containers
log_info "Stopping existing containers..."
docker-compose down

# Build images
log_info "Building Docker images..."
docker-compose build

# Start services
log_info "Starting services..."
docker-compose up -d

# Wait for database to be ready
log_info "Waiting for database to be ready..."
sleep 10

# Run database migrations
log_info "Running database migrations..."
docker-compose exec -T backend-api php artisan migrate --force

# Seed database (only for first deployment)
if [ "$2" == "--seed" ]; then
    log_info "Seeding database..."
    docker-compose exec -T backend-api php artisan db:seed --force
fi

# Check service health
log_info "Checking service health..."
sleep 5

# Check each service
services=("postgres" "redis" "backend-api" "ai-engine" "iot-gateway" "web-dashboard" "nginx")
for service in "${services[@]}"; do
    if docker-compose ps | grep -q "$service.*Up"; then
        log_info "✓ $service is running"
    else
        log_error "✗ $service is not running"
    fi
done

# Display URLs
log_info "Deployment complete! 🎉"
echo ""
echo "Access the application at:"
echo "  - Web Dashboard: http://localhost"
echo "  - Backend API: http://localhost/api"
echo "  - AI Engine: http://localhost/ai"
echo "  - IoT Gateway: http://localhost/iot"
echo ""
echo "To view logs: docker-compose logs -f"
echo "To stop services: docker-compose down"

