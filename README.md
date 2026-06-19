# CONSTRUCTIQ

AI-Powered Construction Field Intelligence & Smart Material Optimization Platform

## Overview

CONSTRUCTIQ is an intelligent construction platform that assists engineers with field analysis, material optimization, machine integration, and offline-first operation. It integrates AI, IoT, mobile computing, and cloud services.

## Features

- 🏗️ **Site Intelligence**: GPS tracking, maps, photos, AI-powered soil analysis
- 📊 **Material Calculator**: Precise calculations for concrete, asphalt, and all construction materials
- 📱 **Mobile-First**: Android app with offline-first architecture
- 🤖 **AI Assistant**: Chatbot for construction guidance and recommendations
- 🔧 **IoT Integration**: Real-time machine monitoring and sensor data
- 📈 **Admin Dashboard**: Web-based project management and analytics
- 🔒 **Secure**: JWT authentication, role-based access control

## System Architecture

```
┌─────────────────┐
│   Mobile App    │ (Kotlin/Android)
│  (Offline-First)│
└────────┬────────┘
         │
    ┌────┴────┐
    │  API    │
    │ Gateway │ (Nginx)
    └────┬────┘
         │
    ┌────┴──────────────────────┐
    │                           │
┌───┴────────┐         ┌────────┴─────┐
│ Backend API│         │  AI Engine   │
│  (Laravel) │         │ (FastAPI)    │
└───┬────────┘         └────────┬─────┘
    │                           │
    └──────────┬────────────────┘
               │
    ┌──────────┴──────────┐
    │   PostgreSQL DB     │
    └─────────────────────┘
```

## Project Structure

```
CONSTRUCTIQ/
├── backend-api/          # Laravel REST API
├── ai-engine/            # Python FastAPI AI services
├── mobile-app/           # Kotlin Android application
├── web-dashboard/        # React/Next.js admin panel
├── iot-gateway/          # IoT sensor data gateway
├── docker/               # Docker configurations
├── docs/                 # Documentation
└── scripts/              # Deployment & utility scripts
```

## Technology Stack

- **Backend**: Laravel 10 (PHP 8.2)
- **AI Engine**: Python 3.11, FastAPI, TensorFlow/PyTorch
- **Mobile**: Kotlin, Jetpack Compose, Room DB
- **Web Dashboard**: Next.js 14, React, TypeScript
- **Database**: PostgreSQL 15
- **Cache**: Redis
- **Message Queue**: RabbitMQ
- **Deployment**: Docker, Nginx, AWS/VPS

## Quick Start

### Prerequisites

- Docker & Docker Compose
- Node.js 18+
- PHP 8.2+
- Python 3.11+
- Android Studio (for mobile development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/constructiq.git
cd constructiq
```

2. Start all services with Docker:
```bash
docker-compose up -d
```

3. Access the services:
- Backend API: http://localhost:8000
- AI Engine: http://localhost:8001
- Web Dashboard: http://localhost:3000
- API Documentation: http://localhost:8000/api/documentation

## Development Setup

See individual README files in each module:
- [Backend API Setup](./backend-api/README.md)
- [AI Engine Setup](./ai-engine/README.md)
- [Mobile App Setup](./mobile-app/README.md)
- [Web Dashboard Setup](./web-dashboard/README.md)

## Documentation

- [API Documentation](./docs/API.md)
- [Database Schema](./docs/DATABASE.md)
- [Deployment Guide](./docs/DEPLOYMENT.md)
- [User Manual](./docs/USER_MANUAL.md)

## License

MIT License

## Contributors

- Your Team

## Support

For issues and questions, please open an issue on GitHub.

