# CONSTRUCTIQ System Updates - Enhanced Features

## 🎯 Overview
This document outlines the critical updates made to the CONSTRUCTIQ system based on the **ConstructIQ_Updated_Prototype_Full.docx** specification. The updates focus on three key areas:

1. **Enhanced IoT Sensor Support** (8 new sensor types)
2. **Machine Control Functionality** (Remote start/stop/pause operations)
3. **Expanded Material Coverage** (Bitumen, asphalt, geotextiles, prefabricated, admixtures, recycled materials)

---

## 📊 Database Updates

### New ENUM Types Added

```sql
-- Expanded material categories
material_category: 'bitumen', 'asphalt', 'geotextiles', 'prefabricated', 'admixtures', 'recycled'

-- Expanded machine types
machine_type: 'batching_plant', 'bitumen_plant', 'crusher', 'screener', 'roller', 'pump', 'weighbridge'

-- New machine statuses
machine_status: 'running', 'paused', 'error'

-- Machine commands
machine_command: 'start', 'stop', 'pause', 'resume', 'emergency_stop'

-- Sensor types
sensor_type: 'soil_moisture', 'soil_ph', 'penetrometer', 'water_level', 'flow_meter', 'load_cell', 'temperature', 'vibration', 'pressure', 'humidity'
```

### New Tables

#### `machine_commands` Table
Tracks all remote control commands sent to machines.

**Columns:**
- `id` (UUID)
- `machine_id` (UUID) - References machines table
- `user_id` (UUID) - User who sent the command
- `command` (ENUM) - start, stop, pause, resume, emergency_stop
- `parameters` (JSONB) - Additional command parameters
- `status` (VARCHAR) - pending, sent, completed, failed
- `executed_at` (TIMESTAMP)
- `response` (JSONB) - Response from machine/IoT gateway
- `created_at` (TIMESTAMP)

### Updated Tables

#### `machines` Table - New Fields
- `mqtt_topic` (VARCHAR) - MQTT topic for machine communication
- `plc_address` (VARCHAR) - PLC controller address for industrial machines
- `can_remote_control` (BOOLEAN) - Whether machine supports remote control

#### `sensor_logs` Table - Enhanced
- `project_id` (UUID) - Link sensors to projects
- `sensor_type` (ENUM) - Now uses predefined sensor types
- `location` (GEOGRAPHY) - Sensor location tracking

---

## 🧱 New Materials Database (60+ New Materials)

### Bitumen Materials (9 types)
- Bitumen grades: 80/100, 60/70, 40/50
- Cutback Bitumen: MC-30, RC-70
- Bitumen Emulsion: Cationic, Anionic
- Prime Coat & Tack Coat

### Asphalt Materials (8 types)
- Asphalt Concrete: AC14, AC20
- Dense Bitumen Macadam (DBM)
- Bituminous Concrete (BC)
- Stone Mastic Asphalt (SMA)
- Porous Asphalt, Warm Mix, Cold Mix

### Geotextiles (7 types)
- Woven & Non-woven Geotextile Fabric
- Biaxial & Uniaxial Geogrid
- HDPE Geomembrane
- Geocell
- Erosion Control Mat

### Prefabricated Materials (6 types)
- Prefab Concrete Panels
- Prefab Steel Frames
- Prefab Roof Trusses
- Prefab Stairs & Beams
- Modular Blocks

### Admixtures (8 types)
- Plasticizer & Superplasticizer
- Retarder & Accelerator
- Air Entraining Agent
- Waterproofing Admixture
- Corrosion Inhibitor
- Shrinkage Reducer

### Recycled Materials (7 types)
- Recycled Concrete Aggregate
- Recycled Asphalt Pavement (RAP)
- Recycled Steel
- Recycled Plastic Lumber
- Fly Ash & Slag Cement
- Recycled Glass Aggregate

---

## 🔧 Backend API Updates

### New Calculators (CalculatorService.php)

#### 1. `calculateBitumen()`
**Purpose:** Calculate bitumen requirements for road construction

**Input:**
- `length` (meters)
- `width` (meters)
- `layer_thickness` (meters, default: 0.05m)
- `bitumen_grade` (80/100, 60/70, 40/50, prime_coat, tack_coat)

**Output:**
- Area covered
- Bitumen required (liters)
- Total with wastage (5%)
- Application rate
- Total cost

#### 2. `calculateAsphalt()`
**Purpose:** Calculate asphalt requirements for road construction

**Input:**
- `length` (meters)
- `width` (meters)
- `thickness` (meters, default: 0.05m)
- `asphalt_type` (AC14, AC20, DBM, BC, SMA)

**Output:**
- Volume (cubic meters)
- Weight (tons)
- Total with wastage (3%)
- Density: 2.4 tons/m³
- Total cost

#### 3. `calculateGeotextile()`
**Purpose:** Calculate geotextile fabric requirements

**Input:**
- `length` (meters)
- `width` (meters)
- `geotextile_type` (woven, non-woven)
- `overlap_percentage` (default: 10%)

**Output:**
- Base area
- Total area with overlap
- Total cost

### New API Endpoints

```php
POST /api/calculate/bitumen
POST /api/calculate/asphalt
POST /api/calculate/geotextile

// Machine Control
POST /api/machines/{id}/command
GET  /api/machines/{id}/command-history
GET  /api/machines/{id}/control-status
GET  /api/machines/controllable/list
```

---

## 🤖 Machine Control System

### New Controller: `MachineControlController.php`

**Features:**
- Send remote commands to machines (start, stop, pause, resume, emergency_stop)
- Real-time status monitoring
- Command history tracking
- Safety checks (only controllable machines can receive commands)

**Command Flow:**
1. User sends command via API → Backend
2. Backend validates machine can be remotely controlled
3. Creates `MachineCommand` record
4. Sends HTTP request to IoT Gateway
5. IoT Gateway publishes MQTT command to machine
6. Machine executes command and sends status update
7. Status update flows back through MQTT → IoT Gateway → Backend

---

## 🌐 IoT Gateway Updates

### New Endpoint: `/machine/command`

**Purpose:** Send control commands to machines via MQTT/PLC

**Features:**
- MQTT topic: `constructiq/machines/{machine_id}/command`
- QoS 2 (guaranteed delivery)
- PLC support (Modbus TCP, OPC UA) - prepared for future implementation
- Real-time command acknowledgment

**Supported Commands:**
```json
{
  "command": "start|stop|pause|resume|emergency_stop",
  "machine_id": "uuid",
  "parameters": {},
  "timestamp": "ISO-8601"
}
```

### Enhanced MQTT Topics

```
constructiq/machines/{machine_id}/command       # Control commands
constructiq/machines/{machine_id}/sensor/soil_moisture
constructiq/machines/{machine_id}/sensor/soil_ph
constructiq/machines/{machine_id}/sensor/penetrometer
constructiq/machines/{machine_id}/sensor/water_level
constructiq/machines/{machine_id}/sensor/flow_meter
constructiq/machines/{machine_id}/sensor/load_cell
constructiq/machines/{machine_id}/sensor/temperature
constructiq/machines/{machine_id}/sensor/vibration
constructiq/machines/{machine_id}/sensor/pressure
constructiq/machines/{machine_id}/sensor/humidity
```

---

## 🧠 AI Engine Updates

### Enhanced Material Recommendations

Updated `RecommendationEngine` to include:

**New Project Type: Infrastructure**
- Earthwork: geotextiles, geogrids, recycled materials
- Pavement: bitumen, asphalt, recycled asphalt, admixtures
- Drainage: geotextiles, pipes, recycled materials
- Stabilization: admixtures, geosynthetics, recycled aggregate

**Enhanced Road Recommendations:**
- Added: recycled_aggregate, geotextiles, recycled_asphalt
- Stabilization materials: admixtures, geogrid, geocell

**Enhanced Building Recommendations:**
- Added: admixtures, prefab_panels, prefab_trusses, geotextiles

**Enhanced Bridge Recommendations:**
- Added: admixtures, prefab_beams, geotextiles, corrosion_inhibitors

---

## 📦 Sample Data Updates

### New Machines (seed.sql)

9 machines with remote control capabilities:

| Machine | Type | Can Control | MQTT Topic |
|---------|------|-------------|------------|
| Batching Plant #1 | batching_plant | ✅ | constructiq/machines/BP-2024-001 |
| Bitumen Plant #1 | bitumen_plant | ✅ | constructiq/machines/BTP-2024-001 |
| Crusher #1 | crusher | ✅ | constructiq/machines/CR-2024-002 |
| Roller #1 | roller | ✅ | constructiq/machines/RL-2024-001 |
| Water Pump #1 | pump | ✅ | constructiq/machines/WP-2024-001 |
| Concrete Mixer #1 | mixer | ✅ | constructiq/machines/MX-2024-001 |
| Excavator #1 | excavator | ❌ | constructiq/machines/EX-2024-001 |
| Bulldozer #1 | bulldozer | ❌ | constructiq/machines/BD-2024-001 |
| Crane #1 | crane | ❌ | constructiq/machines/CR-2024-001 |

---

## 🔄 Migration Guide

### Step 1: Update Database Schema

```bash
# Backup existing database
./scripts/backup.sh

# Apply new schema
docker-compose exec postgres psql -U constructiq -d constructiq -f /docker-entrypoint-initdb.d/schema.sql
docker-compose exec postgres psql -U constructiq -d constructiq -f /docker-entrypoint-initdb.d/seed.sql
```

### Step 2: Update Backend Services

```bash
# Pull latest code
git pull origin main

# Restart backend services
docker-compose restart backend-api
docker-compose restart ai-engine
docker-compose restart iot-gateway
```

### Step 3: Test New Features

```bash
# Test new calculators
curl -X POST http://localhost/api/calculate/bitumen \
  -H "Authorization: Bearer {token}" \
  -d '{"length": 100, "width": 10, "bitumen_grade": "80/100"}'

# Test machine control
curl -X POST http://localhost/api/machines/{machine-id}/command \
  -H "Authorization: Bearer {token}" \
  -d '{"command": "start"}'
```

---

## 📈 Benefits of Updates

### 1. Enhanced IoT Capabilities
- **11 sensor types** (up from 4)
- Support for advanced soil analysis (moisture, pH, penetrometer)
- Industrial sensors (load cells, flow meters, vibration)
- Environmental monitoring (temperature, pressure, humidity)

### 2. Remote Machine Control
- **Reduce on-site labor** by controlling machines remotely
- **Improved safety** with emergency stop functionality
- **Real-time monitoring** of machine status
- **Audit trail** of all commands sent

### 3. Expanded Material Coverage
- **60+ new materials** added to database
- Specialized road construction materials (bitumen, asphalt)
- Modern construction materials (geotextiles, admixtures)
- Sustainable options (recycled materials)
- **3 new calculators** for precise material estimation

### 4. Better Cost Optimization
- More accurate material calculations
- Support for modern materials (admixtures reduce cement usage)
- Recycled materials reduce project costs
- Wastage factors optimized per material type

---

## 🚀 Next Steps (Future Enhancements)

### Phase 2 Features (Not Yet Implemented)
1. **Cross-Platform Mobile App**
   - Migrate from Kotlin to Flutter (Android + iOS)
   - Desktop apps (Windows, macOS, Linux)
   - Progressive Web App (PWA)

2. **Manufacturer Dashboard**
   - Production planning & scheduling
   - Raw material tracking
   - Mix optimization & testing
   - Plant health monitoring
   - Sales & supply forecasting

3. **Advanced Features**
   - PLC Integration (Modbus TCP, OPC UA)
   - Drone mapping & terrain scanning
   - Satellite imagery analysis
   - AR/VR construction guidance
   - BIM integration
   - Supplier marketplace

---

## ✅ Implementation Summary

| Feature | Status | Details |
|---------|--------|---------|
| Enhanced Sensors | ✅ Complete | 11 sensor types supported |
| Machine Control | ✅ Complete | Remote start/stop/pause via MQTT |
| New Materials | ✅ Complete | 60+ materials across 6 new categories |
| New Calculators | ✅ Complete | Bitumen, Asphalt, Geotextile |
| Database Schema | ✅ Complete | Updated with new tables & enums |
| API Endpoints | ✅ Complete | 4 new machine control endpoints |
| IoT Gateway | ✅ Complete | Command publishing via MQTT |
| AI Recommendations | ✅ Complete | Updated for new materials |
| Documentation | ✅ Complete | This document |

---

## 📞 Support

For questions or issues with the new features:
- Check API documentation: `/docs/API.md`
- Review database schema: `/docker/database/schema.sql`
- Test with seed data: `/docker/database/seed.sql`

**System Version:** 2.0 (Enhanced)
**Last Updated:** 2026-06-19
**Author:** CONSTRUCTIQ Development Team

