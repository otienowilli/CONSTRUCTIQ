# CONSTRUCTIQ Quick Start Guide

Get CONSTRUCTIQ up and running in minutes!

## Prerequisites

- Docker and Docker Compose
- Git
- 4GB RAM minimum
- 20GB disk space

## Installation

### 1. Clone Repository

```bash
git clone https://github.com/your-org/constructiq.git
cd constructiq
```

### 2. Configure Environment

```bash
cp .env.example .env
```

Edit `.env` and set:
- `OPENAI_API_KEY` - Your OpenAI API key (for AI features)
- `DB_PASSWORD` - Secure database password
- Other settings as needed

### 3. Start Services

```bash
./scripts/deploy.sh production --seed
```

Or manually:

```bash
docker-compose up -d
```

### 4. Initialize Database

```bash
# Run migrations
docker-compose exec backend-api php artisan migrate

# Seed materials database
docker-compose exec backend-api php artisan db:seed
```

### 5. Access the Application

Open your browser and navigate to:

- **Web Dashboard**: http://localhost
- **API Documentation**: http://localhost/api/docs
- **AI Engine**: http://localhost/ai/docs

## Default Credentials

```
Email: admin@constructiq.com
Password: admin123
```

**⚠️ Change these credentials immediately in production!**

## Quick Tour

### 1. Create Your First Project

1. Login to the dashboard
2. Click "New Project"
3. Fill in project details
4. Click "Create"

### 2. Calculate Materials

1. Go to "Material Calculator"
2. Select calculation type (Concrete, Brickwork, etc.)
3. Enter dimensions
4. Click "Calculate"
5. Save to project

### 3. Analyze Site

1. Go to "Site Analysis"
2. Upload site/soil image
3. View AI analysis results
4. Get recommendations

### 4. Chat with AI

1. Click chat icon
2. Ask construction questions
3. Get instant guidance

## Services Overview

| Service | Port | URL | Purpose |
|---------|------|-----|---------|
| Web Dashboard | 3000 | http://localhost | User interface |
| Backend API | 8000 | http://localhost/api | REST API |
| AI Engine | 8001 | http://localhost/ai | AI services |
| IoT Gateway | 8002 | http://localhost/iot | Machine monitoring |
| PostgreSQL | 5432 | localhost:5432 | Database |
| Redis | 6379 | localhost:6379 | Cache |
| Nginx | 80 | http://localhost | Reverse proxy |

## Common Commands

### View Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f backend-api
```

### Restart Services

```bash
docker-compose restart
```

### Stop Services

```bash
docker-compose down
```

### Backup Database

```bash
./scripts/backup.sh
```

### Run Tests

```bash
# Backend tests
docker-compose exec backend-api php artisan test

# AI engine tests
docker-compose exec ai-engine pytest
```

## Troubleshooting

### Services Not Starting

```bash
# Check status
docker-compose ps

# View logs
docker-compose logs

# Restart
docker-compose restart
```

### Database Connection Error

```bash
# Check database is running
docker-compose ps postgres

# Restart database
docker-compose restart postgres
```

### Port Already in Use

Edit `docker-compose.yml` and change port mappings:

```yaml
ports:
  - "8080:80"  # Change 80 to 8080
```

## Next Steps

1. **Read Documentation**
   - [User Manual](docs/USER_MANUAL.md)
   - [API Documentation](docs/API.md)
   - [Deployment Guide](docs/DEPLOYMENT.md)

2. **Configure for Production**
   - Set up SSL certificates
   - Configure domain name
   - Set strong passwords
   - Enable backups

3. **Customize**
   - Add your materials
   - Configure pricing
   - Set up users and roles
   - Customize branding

4. **Mobile App**
   - Build Android app
   - Install on devices
   - Configure sync

## Getting Help

- **Documentation**: `/docs` directory
- **Issues**: GitHub Issues
- **Email**: support@constructiq.com

## Features

✅ Project Management
✅ Material Calculator (7 types)
✅ AI Chatbot Assistant
✅ Soil Analysis
✅ Machine Monitoring
✅ Report Generation
✅ Offline Mode (Mobile)
✅ Real-time Updates
✅ Cost Estimation
✅ Risk Analysis

## System Requirements

### Development

- Docker Desktop
- 8GB RAM
- 50GB disk space
- Modern browser

### Production

- Linux server (Ubuntu 20.04+)
- 4GB RAM minimum (8GB recommended)
- 20GB disk space
- Docker and Docker Compose
- Domain name (optional)

## Architecture

```
┌─────────────────┐
│  Web Dashboard  │ (Next.js)
└────────┬────────┘
         │
    ┌────▼────┐
    │  Nginx  │ (Reverse Proxy)
    └────┬────┘
         │
    ┌────┴────────────────────┐
    │                         │
┌───▼──────┐          ┌──────▼─────┐
│ Backend  │          │ AI Engine  │
│   API    │◄────────►│  (FastAPI) │
│(Laravel) │          └────────────┘
└────┬─────┘
     │
┌────▼────────┐
│ PostgreSQL  │
│   + Redis   │
└─────────────┘
```

## License

MIT License - See LICENSE file

## Support

Need help? Contact us:
- Email: support@constructiq.com
- Docs: https://docs.constructiq.com
- GitHub: https://github.com/your-org/constructiq

