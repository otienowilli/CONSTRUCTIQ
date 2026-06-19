# CONSTRUCTIQ IoT Gateway

IoT Gateway service for construction machine monitoring and sensor data collection.

## Features

- MQTT broker integration for IoT devices
- Real-time sensor data collection
- WebSocket support for live data streaming
- Machine status monitoring
- Integration with backend API

## Installation

```bash
pip install -r requirements.txt
```

## Configuration

Set environment variables:
```bash
BACKEND_API_URL=http://backend-api:8000
MQTT_BROKER=localhost
MQTT_PORT=1883
```

## Running

```bash
python main.py
```

Or with uvicorn:
```bash
uvicorn main:app --host 0.0.0.0 --port 8002
```

## MQTT Topics

### Subscribe
- `constructiq/machines/#` - All machine topics

### Publish
- `constructiq/machines/{machine_id}/sensor/{sensor_type}` - Sensor data
- `constructiq/machines/{machine_id}/status` - Machine status

## API Endpoints

- `GET /health` - Health check
- `POST /sensor/publish` - Publish sensor data
- `POST /machine/status` - Update machine status
- `WS /ws` - WebSocket for real-time data

## Example Sensor Data

```json
{
  "machine_id": "excavator-001",
  "sensor_type": "fuel_level",
  "value": 75.5,
  "unit": "liters",
  "timestamp": "2024-02-07T10:30:00Z"
}
```

## Docker

```bash
docker build -t constructiq-iot .
docker run -p 8002:8002 -p 1883:1883 constructiq-iot
```

