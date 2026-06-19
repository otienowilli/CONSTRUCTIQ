# CONSTRUCTIQ API Documentation

Base URL: `http://localhost:8000/api`

## Authentication

All API endpoints (except auth endpoints) require authentication using Bearer token.

### Register

```http
POST /auth/register
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123",
  "password_confirmation": "password123",
  "role": "engineer"
}
```

### Login

```http
POST /auth/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "password123"
}
```

Response:
```json
{
  "token": "eyJ0eXAiOiJKV1QiLCJhbGc...",
  "user": {
    "id": "uuid",
    "name": "John Doe",
    "email": "john@example.com",
    "role": "engineer"
  }
}
```

### Logout

```http
POST /auth/logout
Authorization: Bearer {token}
```

## Projects

### List Projects

```http
GET /projects
Authorization: Bearer {token}
```

### Get Project

```http
GET /projects/{id}
Authorization: Bearer {token}
```

### Create Project

```http
POST /projects
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "Building Construction",
  "description": "5-story residential building",
  "type": "building",
  "location": {
    "latitude": -1.2921,
    "longitude": 36.8219
  },
  "budget": 5000000,
  "start_date": "2024-03-01",
  "end_date": "2024-12-31"
}
```

### Update Project

```http
PUT /projects/{id}
Authorization: Bearer {token}
Content-Type: application/json

{
  "status": "in_progress",
  "budget": 5500000
}
```

### Delete Project

```http
DELETE /projects/{id}
Authorization: Bearer {token}
```

## Materials

### List Materials

```http
GET /materials?category=civil
Authorization: Bearer {token}
```

Query Parameters:
- `category` - Filter by category (civil, roads, finishing, etc.)
- `search` - Search by name

### Get Material

```http
GET /materials/{id}
Authorization: Bearer {token}
```

## Material Calculator

### Calculate Concrete

```http
POST /calculator/concrete
Authorization: Bearer {token}
Content-Type: application/json

{
  "length": 10,
  "width": 10,
  "height": 0.15,
  "grade": "C20",
  "project_id": "uuid"
}
```

Response:
```json
{
  "volume": 15,
  "materials": [
    {
      "material": "Cement",
      "quantity": 42.86,
      "unit": "bags",
      "cost": 21430
    },
    {
      "material": "Sand",
      "quantity": 23.1,
      "unit": "m³",
      "cost": 34650
    }
  ],
  "total_cost": 89430,
  "mix_ratio": "1:2:3"
}
```

### Calculate Brickwork

```http
POST /calculator/brickwork
Authorization: Bearer {token}
Content-Type: application/json

{
  "length": 10,
  "height": 3,
  "thickness": 0.23,
  "mortar_ratio": "1:4",
  "project_id": "uuid"
}
```

### Calculate Plastering

```http
POST /calculator/plastering
Authorization: Bearer {token}
Content-Type: application/json

{
  "area": 100,
  "thickness": 0.015,
  "mix_ratio": "1:4",
  "project_id": "uuid"
}
```

### Calculate Painting

```http
POST /calculator/painting
Authorization: Bearer {token}
Content-Type: application/json

{
  "area": 200,
  "coats": 2,
  "paint_type": "emulsion",
  "project_id": "uuid"
}
```

### Calculate Excavation

```http
POST /calculator/excavation
Authorization: Bearer {token}
Content-Type: application/json

{
  "length": 20,
  "width": 15,
  "depth": 2,
  "soil_type": "normal",
  "project_id": "uuid"
}
```

### Calculate Road

```http
POST /calculator/road
Authorization: Bearer {token}
Content-Type: application/json

{
  "length": 1000,
  "width": 7,
  "layers": {
    "subgrade": 0.3,
    "subbase": 0.2,
    "base": 0.15,
    "asphalt": 0.05
  },
  "project_id": "uuid"
}
```

### Calculate Roofing

```http
POST /calculator/roofing
Authorization: Bearer {token}
Content-Type: application/json

{
  "area": 150,
  "roof_type": "iron_sheets",
  "pitch": 30,
  "project_id": "uuid"
}
```

### Calculate Bitumen (NEW)

```http
POST /calculator/bitumen
Authorization: Bearer {token}
Content-Type: application/json

{
  "length": 100,
  "width": 10,
  "layer_thickness": 0.05,
  "bitumen_grade": "80/100",
  "project_id": "uuid"
}
```

Response:
```json
{
  "calculation_id": "uuid",
  "results": {
    "area": 1000,
    "bitumen_required": 1200,
    "total_with_wastage": 1260,
    "unit": "liters",
    "grade": "80/100",
    "application_rate": 1.2,
    "total_cost": 119700
  }
}
```

### Calculate Asphalt (NEW)

```http
POST /calculator/asphalt
Authorization: Bearer {token}
Content-Type: application/json

{
  "length": 100,
  "width": 10,
  "thickness": 0.05,
  "asphalt_type": "AC14",
  "project_id": "uuid"
}
```

Response:
```json
{
  "calculation_id": "uuid",
  "results": {
    "volume": 50,
    "weight": 120,
    "total_with_wastage": 123.6,
    "unit": "tons",
    "type": "AC14",
    "density": 2.4,
    "thickness": 0.05,
    "total_cost": 1050600
  }
}
```

### Calculate Geotextile (NEW)

```http
POST /calculator/geotextile
Authorization: Bearer {token}
Content-Type: application/json

{
  "length": 100,
  "width": 50,
  "geotextile_type": "woven",
  "overlap_percentage": 10,
  "project_id": "uuid"
}
```

Response:
```json
{
  "calculation_id": "uuid",
  "results": {
    "base_area": 5000,
    "overlap_percentage": 10,
    "total_area": 5500,
    "unit": "square meters",
    "type": "woven",
    "total_cost": 990000
  }
}
```

## Site Analysis

### Create Site Analysis

```http
POST /site-analysis
Authorization: Bearer {token}
Content-Type: application/json

{
  "project_id": "uuid",
  "location": {
    "latitude": -1.2921,
    "longitude": 36.8219
  },
  "soil_type": "clay",
  "images": ["url1", "url2"]
}
```

### Get Site Analysis

```http
GET /site-analysis/{project_id}
Authorization: Bearer {token}
```

## Machines

### List Machines

```http
GET /machines
Authorization: Bearer {token}
```

### Get Machine

```http
GET /machines/{id}
Authorization: Bearer {token}
```

### Send Machine Command (NEW)

Control machines remotely (start, stop, pause, resume, emergency_stop).

```http
POST /machines/{id}/command
Authorization: Bearer {token}
Content-Type: application/json

{
  "command": "start",
  "parameters": {
    "speed": 50,
    "mode": "auto"
  }
}
```

Response:
```json
{
  "message": "Command 'start' sent to machine successfully",
  "command_id": "uuid",
  "status": "sent",
  "response": {
    "status": "success",
    "timestamp": "2026-06-19T10:30:00Z"
  }
}
```

**Supported Commands:**
- `start` - Start machine operation
- `stop` - Stop machine operation
- `pause` - Pause current operation
- `resume` - Resume paused operation
- `emergency_stop` - Emergency shutdown

**Note:** Only machines with `can_remote_control: true` can receive commands.

### Get Machine Control Status (NEW)

```http
GET /machines/{id}/control-status
Authorization: Bearer {token}
```

Response:
```json
{
  "machine": {
    "id": "uuid",
    "name": "Batching Plant #1",
    "type": "batching_plant",
    "status": "running",
    "can_remote_control": true,
    "mqtt_topic": "constructiq/machines/BP-2024-001"
  },
  "sensor_data": [
    {
      "sensor_type": "temperature",
      "value": 45.5,
      "unit": "°C",
      "timestamp": "2026-06-19T10:29:00Z"
    }
  ]
}
```

### Get Machine Command History (NEW)

```http
GET /machines/{id}/command-history
Authorization: Bearer {token}
```

Response:
```json
{
  "data": [
    {
      "id": "uuid",
      "command": "start",
      "status": "completed",
      "user": {
        "name": "John Engineer",
        "email": "engineer@constructiq.com"
      },
      "executed_at": "2026-06-19T10:30:00Z",
      "created_at": "2026-06-19T10:29:55Z"
    }
  ],
  "total": 15,
  "per_page": 20
}
```

### Get Controllable Machines (NEW)

Get list of all machines that support remote control.

```http
GET /machines/controllable/list
Authorization: Bearer {token}
```

Response:
```json
[
  {
    "id": "uuid",
    "name": "Batching Plant #1",
    "type": "batching_plant",
    "status": "idle",
    "can_remote_control": true,
    "mqtt_topic": "constructiq/machines/BP-2024-001"
  },
  {
    "id": "uuid",
    "name": "Bitumen Plant #1",
    "type": "bitumen_plant",
    "status": "idle",
    "can_remote_control": true,
    "mqtt_topic": "constructiq/machines/BTP-2024-001"
  }
]
```

## Reports

### List Reports

```http
GET /reports?project_id={uuid}
Authorization: Bearer {token}
```

### Generate Report

```http
POST /reports
Authorization: Bearer {token}
Content-Type: application/json

{
  "project_id": "uuid",
  "type": "progress",
  "period": "weekly"
}
```

## AI Services

Base URL: `http://localhost:8001`

### Chat with AI

```http
POST /chat
Content-Type: application/json

{
  "message": "How much concrete do I need for a 10x10x0.15m slab?",
  "user_id": "uuid",
  "project_id": "uuid"
}
```

### Analyze Soil

```http
POST /analyze/soil
Content-Type: application/json

{
  "image_url": "https://example.com/soil.jpg"
}
```

### Get Material Recommendations

```http
POST /recommendations/materials
Content-Type: application/json

{
  "project_type": "building",
  "budget": 1000000
}
```

### Estimate Cost

```http
POST /estimate/cost
Content-Type: application/json

{
  "project_type": "building",
  "size": 100,
  "quality": "standard"
}
```

### Analyze Risk

```http
POST /analyze/risk
Content-Type: application/json

{
  "project_type": "building",
  "budget": 1000000,
  "timeline_months": 6
}
```

## Error Responses

All endpoints return standard error responses:

```json
{
  "error": "Error message",
  "code": "ERROR_CODE",
  "details": {}
}
```

HTTP Status Codes:
- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `422` - Validation Error
- `500` - Server Error

