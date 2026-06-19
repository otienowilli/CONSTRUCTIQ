# CONSTRUCTIQ Backend API

Laravel-based REST API for the CONSTRUCTIQ platform.

## Features

- User authentication with Laravel Sanctum
- Project management
- Material calculator (concrete, brickwork, plastering, painting, excavation, roads, roofing)
- Site analysis integration
- IoT machine monitoring
- Report generation
- AI chatbot integration
- Role-based access control

## Installation

### Prerequisites

- PHP 8.2+
- Composer
- PostgreSQL 15+
- Redis

### Setup

1. Install dependencies:
```bash
composer install
```

2. Copy environment file:
```bash
cp .env.example .env
```

3. Generate application key:
```bash
php artisan key:generate
```

4. Run migrations:
```bash
php artisan migrate
```

5. Seed database:
```bash
php artisan db:seed
```

6. Start development server:
```bash
php artisan serve
```

The API will be available at `http://localhost:8000`

## API Endpoints

### Authentication
- `POST /api/register` - Register new user
- `POST /api/login` - Login
- `POST /api/logout` - Logout
- `GET /api/user` - Get authenticated user

### Projects
- `GET /api/projects` - List projects
- `POST /api/projects` - Create project
- `GET /api/projects/{id}` - Get project details
- `PUT /api/projects/{id}` - Update project
- `DELETE /api/projects/{id}` - Delete project

### Materials
- `GET /api/materials` - List all materials
- `GET /api/materials/category/{category}` - Get materials by category
- `GET /api/materials/{id}` - Get material details

### Calculators
- `POST /api/calculate/concrete` - Calculate concrete requirements
- `POST /api/calculate/brickwork` - Calculate brickwork requirements
- `POST /api/calculate/plastering` - Calculate plastering requirements
- `POST /api/calculate/painting` - Calculate painting requirements
- `POST /api/calculate/excavation` - Calculate excavation requirements
- `POST /api/calculate/road` - Calculate road construction requirements
- `POST /api/calculate/roofing` - Calculate roofing requirements
- `GET /api/calculations/history` - Get calculation history

### Site Analysis
- `POST /api/site-analysis` - Create site analysis
- `GET /api/site-analysis/{project_id}` - Get project site analyses
- `POST /api/site-analysis/soil` - Analyze soil (AI)
- `POST /api/site-analysis/slope` - Analyze slope

### Machines
- `GET /api/machines` - List all machines
- `POST /api/machines` - Register new machine
- `GET /api/machines/{id}` - Get machine details
- `GET /api/machines/{id}/sensors` - Get sensor data
- `POST /api/machines/{id}/maintenance` - Log maintenance

### Reports
- `GET /api/reports` - List reports
- `POST /api/reports` - Create report
- `GET /api/reports/{id}` - Get report
- `POST /api/reports/{id}/generate-pdf` - Generate PDF
- `POST /api/reports/{id}/submit` - Submit report
- `POST /api/reports/{id}/approve` - Approve report

### Chat
- `POST /api/chat` - Send message to AI chatbot
- `GET /api/chat/history` - Get chat history
- `DELETE /api/chat/clear` - Clear chat history

### Dashboard
- `GET /api/dashboard/stats` - Get dashboard statistics

## Testing

Run tests:
```bash
php artisan test
```

## Docker

Build and run with Docker:
```bash
docker build -t constructiq-backend .
docker run -p 8000:8000 constructiq-backend
```

## License

MIT

