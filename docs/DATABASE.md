# CONSTRUCTIQ Database Schema

## Overview

PostgreSQL database with the following main entities:
- Users & Authentication
- Projects & Sites
- Materials & Calculations
- Machines & IoT Sensors
- Reports & Analytics

## Entity Relationship Diagram

```
Users ──< Projects ──< SiteAnalysis
  │         │
  │         ├──< MaterialCalculations
  │         │
  │         └──< Reports
  │
  └──< ActivityLogs

Materials ──< MaterialCalculations
          │
          └──< MaterialPrices

Machines ──< SensorLogs
         │
         └──< MaintenanceLogs

Projects ──< ProjectMembers
         │
         └──< ProjectDocuments
```

## Tables

### 1. users
```sql
id: UUID PRIMARY KEY
name: VARCHAR(255)
email: VARCHAR(255) UNIQUE
password: VARCHAR(255)
role: ENUM('admin', 'engineer', 'supervisor', 'worker')
phone: VARCHAR(20)
company: VARCHAR(255)
avatar: TEXT
email_verified_at: TIMESTAMP
is_active: BOOLEAN DEFAULT true
created_at: TIMESTAMP
updated_at: TIMESTAMP
deleted_at: TIMESTAMP (soft delete)
```

### 2. projects
```sql
id: UUID PRIMARY KEY
user_id: UUID FOREIGN KEY -> users(id)
name: VARCHAR(255)
type: ENUM('building', 'road', 'bridge', 'infrastructure')
status: ENUM('planning', 'active', 'paused', 'completed')
location: GEOGRAPHY(POINT)
address: TEXT
start_date: DATE
end_date: DATE
budget: DECIMAL(15,2)
soil_type: VARCHAR(100)
slope_percentage: DECIMAL(5,2)
weather_conditions: JSONB
metadata: JSONB
created_at: TIMESTAMP
updated_at: TIMESTAMP
```

### 3. materials
```sql
id: UUID PRIMARY KEY
name: VARCHAR(255)
category: ENUM('civil', 'roads', 'finishing', 'plumbing', 'electrical', 'structural')
unit: VARCHAR(50)
base_price: DECIMAL(10,2)
description: TEXT
specifications: JSONB
image_url: TEXT
is_active: BOOLEAN DEFAULT true
created_at: TIMESTAMP
updated_at: TIMESTAMP
```

### 4. material_calculations
```sql
id: UUID PRIMARY KEY
project_id: UUID FOREIGN KEY -> projects(id)
user_id: UUID FOREIGN KEY -> users(id)
calculation_type: VARCHAR(100)
inputs: JSONB
results: JSONB
materials_used: JSONB
total_cost: DECIMAL(15,2)
notes: TEXT
created_at: TIMESTAMP
updated_at: TIMESTAMP
```

### 5. site_analysis
```sql
id: UUID PRIMARY KEY
project_id: UUID FOREIGN KEY -> projects(id)
user_id: UUID FOREIGN KEY -> users(id)
location: GEOGRAPHY(POINT)
photos: JSONB
soil_analysis: JSONB
ai_recommendations: JSONB
slope_data: JSONB
weather_data: JSONB
created_at: TIMESTAMP
updated_at: TIMESTAMP
```

### 6. machines
```sql
id: UUID PRIMARY KEY
name: VARCHAR(255)
type: ENUM('excavator', 'mixer', 'crane', 'bulldozer', 'compactor', 'other')
model: VARCHAR(255)
serial_number: VARCHAR(255) UNIQUE
status: ENUM('active', 'idle', 'maintenance', 'offline')
project_id: UUID FOREIGN KEY -> projects(id)
location: GEOGRAPHY(POINT)
specifications: JSONB
last_maintenance: TIMESTAMP
next_maintenance: TIMESTAMP
created_at: TIMESTAMP
updated_at: TIMESTAMP
```

### 7. sensor_logs
```sql
id: UUID PRIMARY KEY
machine_id: UUID FOREIGN KEY -> machines(id)
sensor_type: VARCHAR(100)
value: DECIMAL(10,2)
unit: VARCHAR(50)
timestamp: TIMESTAMP
metadata: JSONB
created_at: TIMESTAMP
```

### 8. reports
```sql
id: UUID PRIMARY KEY
project_id: UUID FOREIGN KEY -> projects(id)
user_id: UUID FOREIGN KEY -> users(id)
title: VARCHAR(255)
type: ENUM('daily', 'weekly', 'monthly', 'final')
content: JSONB
pdf_url: TEXT
status: ENUM('draft', 'submitted', 'approved')
created_at: TIMESTAMP
updated_at: TIMESTAMP
```

### 9. chat_messages
```sql
id: UUID PRIMARY KEY
user_id: UUID FOREIGN KEY -> users(id)
project_id: UUID FOREIGN KEY -> projects(id)
message: TEXT
response: TEXT
context: JSONB
created_at: TIMESTAMP
```

### 10. activity_logs
```sql
id: UUID PRIMARY KEY
user_id: UUID FOREIGN KEY -> users(id)
action: VARCHAR(255)
entity_type: VARCHAR(100)
entity_id: UUID
changes: JSONB
ip_address: VARCHAR(45)
user_agent: TEXT
created_at: TIMESTAMP
```

## Indexes

```sql
CREATE INDEX idx_projects_user_id ON projects(user_id);
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_projects_location ON projects USING GIST(location);
CREATE INDEX idx_materials_category ON materials(category);
CREATE INDEX idx_sensor_logs_machine_id ON sensor_logs(machine_id);
CREATE INDEX idx_sensor_logs_timestamp ON sensor_logs(timestamp);
CREATE INDEX idx_activity_logs_user_id ON activity_logs(user_id);
CREATE INDEX idx_activity_logs_created_at ON activity_logs(created_at);
```

## Sample Queries

### Get project with all calculations
```sql
SELECT p.*, 
       json_agg(mc.*) as calculations
FROM projects p
LEFT JOIN material_calculations mc ON p.id = mc.project_id
WHERE p.id = ?
GROUP BY p.id;
```

### Get machine sensor data for last 24 hours
```sql
SELECT m.name, sl.*
FROM machines m
JOIN sensor_logs sl ON m.id = sl.machine_id
WHERE sl.timestamp > NOW() - INTERVAL '24 hours'
ORDER BY sl.timestamp DESC;
```

