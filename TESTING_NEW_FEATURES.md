# Testing New CONSTRUCTIQ Features

This guide helps you test the newly implemented features in CONSTRUCTIQ v2.0.

---

## 🚀 Quick Start

### 1. Update Database

```bash
# Stop all services
docker-compose down

# Start database service
docker-compose up -d postgres

# Wait for postgres to be ready (about 10 seconds)
sleep 10

# Apply new schema and seed data
docker-compose exec postgres psql -U constructiq -d constructiq -f /docker-entrypoint-initdb.d/schema.sql
docker-compose exec postgres psql -U constructiq -d constructiq -f /docker-entrypoint-initdb.d/seed.sql

# Start all services
docker-compose up -d
```

### 2. Verify Services are Running

```bash
# Check service health
curl http://localhost:8000/api/health        # Backend API
curl http://localhost:8001/health            # AI Engine
curl http://localhost:8002/health            # IoT Gateway

# Expected response: {"status": "ok", ...}
```

---

## 🧪 Test New Features

### Feature 1: Bitumen Calculator

```bash
# Login first
TOKEN=$(curl -X POST http://localhost:8000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"engineer@constructiq.com","password":"password"}' \
  | jq -r '.token')

# Test bitumen calculator
curl -X POST http://localhost:8000/api/calculate/bitumen \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "length": 100,
    "width": 10,
    "bitumen_grade": "80/100"
  }'
```

**Expected Output:**
```json
{
  "calculation_id": "...",
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

---

### Feature 2: Asphalt Calculator

```bash
curl -X POST http://localhost:8000/api/calculate/asphalt \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "length": 100,
    "width": 10,
    "thickness": 0.05,
    "asphalt_type": "AC14"
  }'
```

**Expected Output:**
```json
{
  "calculation_id": "...",
  "results": {
    "volume": 50,
    "weight": 120,
    "total_with_wastage": 123.6,
    "unit": "tons",
    "type": "AC14",
    "density": 2.4,
    "total_cost": 1050600
  }
}
```

---

### Feature 3: Geotextile Calculator

```bash
curl -X POST http://localhost:8000/api/calculate/geotextile \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "length": 100,
    "width": 50,
    "geotextile_type": "woven",
    "overlap_percentage": 10
  }'
```

**Expected Output:**
```json
{
  "calculation_id": "...",
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

---

### Feature 4: List Controllable Machines

```bash
curl -X GET http://localhost:8000/api/machines/controllable/list \
  -H "Authorization: Bearer $TOKEN"
```

**Expected Output:**
```json
[
  {
    "id": "...",
    "name": "Batching Plant #1",
    "type": "batching_plant",
    "status": "idle",
    "can_remote_control": true,
    "mqtt_topic": "constructiq/machines/BP-2024-001"
  },
  {
    "id": "...",
    "name": "Bitumen Plant #1",
    "type": "bitumen_plant",
    "status": "idle",
    "can_remote_control": true,
    "mqtt_topic": "constructiq/machines/BTP-2024-001"
  }
]
```

---

### Feature 5: Send Machine Control Command

```bash
# Get machine ID from previous response
MACHINE_ID="<copy-id-from-above>"

# Send START command
curl -X POST http://localhost:8000/api/machines/$MACHINE_ID/command \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "command": "start",
    "parameters": {
      "speed": 75,
      "mode": "auto"
    }
  }'
```

**Expected Output:**
```json
{
  "message": "Command sent successfully",
  "command_id": "...",
  "status": "sent",
  "response": {
    "status": "success",
    "message": "Command 'start' sent to machine ...",
    "topic": "constructiq/machines/BP-2024-001/command",
    "timestamp": "2026-06-19T10:30:00.000000Z"
  }
}
```

**Test Other Commands:**
```bash
# STOP command
curl -X POST http://localhost:8000/api/machines/$MACHINE_ID/command \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"command": "stop"}'

# PAUSE command
curl -X POST http://localhost:8000/api/machines/$MACHINE_ID/command \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"command": "pause"}'
```

---

### Feature 6: View Command History

```bash
curl -X GET http://localhost:8000/api/machines/$MACHINE_ID/command-history \
  -H "Authorization: Bearer $TOKEN"
```

**Expected Output:**
```json
{
  "data": [
    {
      "id": "...",
      "command": "start",
      "status": "sent",
      "parameters": {"speed": 75, "mode": "auto"},
      "user": {
        "name": "John Engineer",
        "email": "engineer@constructiq.com"
      },
      "executed_at": "2026-06-19T10:30:00Z",
      "created_at": "2026-06-19T10:29:55Z"
    }
  ]
}
```

---

### Feature 7: New Materials Database

```bash
# List bitumen materials
curl -X GET http://localhost:8000/api/materials/category/bitumen \
  -H "Authorization: Bearer $TOKEN"

# List asphalt materials
curl -X GET http://localhost:8000/api/materials/category/asphalt \
  -H "Authorization: Bearer $TOKEN"

# List geotextiles
curl -X GET http://localhost:8000/api/materials/category/geotextiles \
  -H "Authorization: Bearer $TOKEN"

# List prefabricated materials
curl -X GET http://localhost:8000/api/materials/category/prefabricated \
  -H "Authorization: Bearer $TOKEN"

# List admixtures
curl -X GET http://localhost:8000/api/materials/category/admixtures \
  -H "Authorization: Bearer $TOKEN"

# List recycled materials
curl -X GET http://localhost:8000/api/materials/category/recycled \
  -H "Authorization: Bearer $TOKEN"
```

---

## 🔍 Verify Database Updates

### Check New Material Categories

```bash
docker-compose exec postgres psql -U constructiq -d constructiq -c \
  "SELECT category, COUNT(*) FROM materials GROUP BY category ORDER BY category;"
```

**Expected Output:**
```
   category     | count
----------------+-------
 admixtures     |   8
 asphalt        |   8
 bitumen        |   9
 civil          |  17
 electrical     |   7
 finishing      |  10
 geotextiles    |   7
 plumbing       |  10
 prefabricated  |   6
 recycled       |   7
 roads          |   4
 structural     |   5
```

### Check Machines with Remote Control

```bash
docker-compose exec postgres psql -U constructiq -d constructiq -c \
  "SELECT name, type, can_remote_control FROM machines WHERE can_remote_control = true;"
```

**Expected Output:**
```
       name         |      type       | can_remote_control
--------------------+-----------------+--------------------
 Concrete Mixer #1  | mixer           | t
 Batching Plant #1  | batching_plant  | t
 Bitumen Plant #1   | bitumen_plant   | t
 Crusher #1         | crusher         | t
 Roller #1          | roller          | t
 Water Pump #1      | pump            | t
```

---

## 🐛 Troubleshooting

### Issue: "Machine does not support remote control"

**Cause:** Trying to send commands to machines with `can_remote_control = false`

**Solution:** Use only machines from the `/api/machines/controllable/list` endpoint

---

### Issue: "Failed to send command to machine"

**Possible Causes:**
1. IoT Gateway service is not running
2. MQTT broker connection issue

**Solution:**
```bash
# Check IoT Gateway health
curl http://localhost:8002/health

# Check docker logs
docker-compose logs iot-gateway

# Restart IoT Gateway
docker-compose restart iot-gateway
```

---

### Issue: "Material not found" in calculators

**Cause:** Database seed data not loaded

**Solution:**
```bash
# Re-run seed script
docker-compose exec postgres psql -U constructiq -d constructiq -f /docker-entrypoint-initdb.d/seed.sql
```

---

## 📊 Performance Metrics

### Expected Response Times

| Endpoint | Expected Time |
|----------|---------------|
| Calculator APIs | < 200ms |
| Machine Control | < 500ms |
| Material Listing | < 100ms |
| Command History | < 150ms |

### Test Load Performance

```bash
# Install Apache Bench (if not installed)
# macOS: brew install httpd
# Ubuntu: sudo apt-get install apache2-utils

# Test bitumen calculator (100 requests, 10 concurrent)
ab -n 100 -c 10 -T "application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -p bitumen_test.json \
  http://localhost:8000/api/calculate/bitumen
```

---

## ✅ Checklist

After testing, verify:

- [ ] All 3 new calculators working (bitumen, asphalt, geotextile)
- [ ] Machine control commands sent successfully
- [ ] Command history retrievable
- [ ] 6 new material categories in database
- [ ] Controllable machines list returns results
- [ ] IoT Gateway receives and publishes MQTT commands
- [ ] API documentation updated
- [ ] No errors in docker logs

---

## 📝 Report Issues

If you encounter issues:

1. Check logs: `docker-compose logs [service-name]`
2. Verify database: Use SQL queries above
3. Check API documentation: `/docs/API.md`
4. Review update summary: `/SYSTEM_UPDATES.md`

**System Version:** 2.0 (Enhanced)
**Last Updated:** 2026-06-19


