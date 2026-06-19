# CONSTRUCTIQ Deployment Guide

This guide covers deploying CONSTRUCTIQ to production environments.

## Prerequisites

- Docker and Docker Compose installed
- Domain name (optional, for SSL)
- Server with at least 4GB RAM and 20GB storage
- PostgreSQL 15+ with PostGIS extension
- Redis 7+

## Quick Start

### 1. Clone Repository

```bash
git clone https://github.com/your-org/constructiq.git
cd constructiq
```

### 2. Configure Environment

```bash
cp .env.example .env
```

Edit `.env` and configure:

```env
# Database
DB_HOST=postgres
DB_PORT=5432
DB_DATABASE=constructiq
DB_USERNAME=constructiq
DB_PASSWORD=your_secure_password

# Redis
REDIS_HOST=redis
REDIS_PORT=6379

# Laravel
APP_KEY=base64:your_app_key_here
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-domain.com

# AI Engine
OPENAI_API_KEY=your_openai_api_key

# MQTT
MQTT_BROKER=mosquitto
MQTT_PORT=1883
```

### 3. Deploy

```bash
./scripts/deploy.sh production --seed
```

The `--seed` flag will populate the database with initial materials data (only use on first deployment).

## Manual Deployment

### Build and Start Services

```bash
# Pull latest images
docker-compose pull

# Build images
docker-compose build

# Start services
docker-compose up -d
```

### Initialize Database

```bash
# Run migrations
docker-compose exec backend-api php artisan migrate --force

# Seed materials database (first time only)
docker-compose exec backend-api php artisan db:seed --force

# Generate application key
docker-compose exec backend-api php artisan key:generate
```

### Verify Deployment

```bash
# Check running services
docker-compose ps

# View logs
docker-compose logs -f

# Test health endpoints
curl http://localhost/health
curl http://localhost/api/health
curl http://localhost/ai/health
curl http://localhost/iot/health
```

## SSL Configuration

### Using Let's Encrypt

1. Install Certbot:
```bash
sudo apt-get install certbot
```

2. Generate certificates:
```bash
sudo certbot certonly --standalone -d your-domain.com
```

3. Update `docker/nginx/nginx.conf`:
```nginx
server {
    listen 443 ssl http2;
    server_name your-domain.com;
    
    ssl_certificate /etc/letsencrypt/live/your-domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/your-domain.com/privkey.pem;
    
    # ... rest of configuration
}
```

4. Mount certificates in `docker-compose.yml`:
```yaml
nginx:
  volumes:
    - /etc/letsencrypt:/etc/letsencrypt:ro
```

## Backup and Restore

### Create Backup

```bash
./scripts/backup.sh
```

Backups are stored in `./backups/` directory.

### Restore from Backup

```bash
./scripts/restore.sh 20240207_120000
```

Replace timestamp with your backup timestamp.

## Monitoring

### View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f backend-api
docker-compose logs -f ai-engine
```

### Resource Usage

```bash
docker stats
```

## Scaling

### Horizontal Scaling

Scale specific services:

```bash
# Scale backend API
docker-compose up -d --scale backend-api=3

# Scale AI engine
docker-compose up -d --scale ai-engine=2
```

### Load Balancing

Update `docker/nginx/nginx.conf` to add multiple upstream servers:

```nginx
upstream backend_api {
    server backend-api-1:8000;
    server backend-api-2:8000;
    server backend-api-3:8000;
}
```

## CI/CD with GitHub Actions

The project includes GitHub Actions workflow for automated testing and deployment.

### Setup

1. Add secrets to GitHub repository:
   - `DOCKER_USERNAME` - Docker Hub username
   - `DOCKER_PASSWORD` - Docker Hub password
   - `DEPLOY_HOST` - Production server IP/hostname
   - `DEPLOY_USER` - SSH username
   - `DEPLOY_KEY` - SSH private key

2. Push to `main` branch to trigger deployment

## Production Checklist

- [ ] Configure environment variables
- [ ] Set strong database passwords
- [ ] Configure SSL certificates
- [ ] Set up automated backups
- [ ] Configure monitoring and alerts
- [ ] Set up log rotation
- [ ] Configure firewall rules
- [ ] Set up domain and DNS
- [ ] Test all services
- [ ] Configure email for notifications
- [ ] Set up error tracking (e.g., Sentry)

## Troubleshooting

### Services Not Starting

```bash
# Check logs
docker-compose logs

# Restart services
docker-compose restart

# Rebuild and restart
docker-compose down
docker-compose up -d --build
```

### Database Connection Issues

```bash
# Check database is running
docker-compose ps postgres

# Check database logs
docker-compose logs postgres

# Test connection
docker-compose exec postgres psql -U constructiq -d constructiq
```

### Performance Issues

- Increase container resources in `docker-compose.yml`
- Enable Redis caching
- Optimize database queries
- Scale services horizontally

## Support

For issues and questions:
- GitHub Issues: https://github.com/your-org/constructiq/issues
- Documentation: https://docs.constructiq.com
- Email: support@constructiq.com

