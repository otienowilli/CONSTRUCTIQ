"""
CONSTRUCTIQ IoT Gateway
Handles machine sensor data collection and real-time monitoring
"""

import asyncio
import json
import os
from datetime import datetime
from typing import Dict, Any, List

from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import paho.mqtt.client as mqtt
import httpx

app = FastAPI(
    title="CONSTRUCTIQ IoT Gateway",
    description="IoT Gateway for construction machine monitoring",
    version="1.0.0"
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Configuration
BACKEND_API_URL = os.getenv("BACKEND_API_URL", "http://backend-api:8000")
MQTT_BROKER = os.getenv("MQTT_BROKER", "localhost")
MQTT_PORT = int(os.getenv("MQTT_PORT", 1883))

# WebSocket connections
active_connections: List[WebSocket] = []


# Models
class SensorData(BaseModel):
    machine_id: str
    sensor_type: str
    value: float
    unit: str
    timestamp: str = None


class MachineStatus(BaseModel):
    machine_id: str
    status: str
    location: Dict[str, float] = None


class MachineCommand(BaseModel):
    machine_id: str
    mqtt_topic: str
    plc_address: str = None
    command: str  # start, stop, pause, resume, emergency_stop
    parameters: Dict[str, Any] = {}


# MQTT Client Setup
mqtt_client = mqtt.Client()


def on_connect(client, userdata, flags, rc):
    print(f"Connected to MQTT broker with result code {rc}")
    # Subscribe to all machine topics
    client.subscribe("constructiq/machines/#")


def on_message(client, userdata, msg):
    """Handle incoming MQTT messages"""
    try:
        topic = msg.topic
        payload = json.loads(msg.payload.decode())
        
        print(f"Received message on {topic}: {payload}")
        
        # Process sensor data
        if "sensor" in topic:
            asyncio.create_task(process_sensor_data(payload))
        elif "status" in topic:
            asyncio.create_task(process_machine_status(payload))
        
        # Broadcast to WebSocket clients
        asyncio.create_task(broadcast_to_websockets(payload))
        
    except Exception as e:
        print(f"Error processing MQTT message: {e}")


mqtt_client.on_connect = on_connect
mqtt_client.on_message = on_message


async def process_sensor_data(data: Dict[str, Any]):
    """Process and store sensor data"""
    try:
        # Send to backend API
        async with httpx.AsyncClient() as client:
            response = await client.post(
                f"{BACKEND_API_URL}/api/sensors/log",
                json=data,
                timeout=10.0
            )
            print(f"Sensor data logged: {response.status_code}")
    except Exception as e:
        print(f"Error logging sensor data: {e}")


async def process_machine_status(data: Dict[str, Any]):
    """Process machine status updates"""
    try:
        async with httpx.AsyncClient() as client:
            response = await client.put(
                f"{BACKEND_API_URL}/api/machines/{data['machine_id']}",
                json={"status": data["status"]},
                timeout=10.0
            )
            print(f"Machine status updated: {response.status_code}")
    except Exception as e:
        print(f"Error updating machine status: {e}")


async def broadcast_to_websockets(data: Dict[str, Any]):
    """Broadcast data to all connected WebSocket clients"""
    for connection in active_connections:
        try:
            await connection.send_json(data)
        except:
            active_connections.remove(connection)


# API Endpoints
@app.get("/")
@app.get("/health")
async def health_check():
    return {
        "status": "ok",
        "service": "CONSTRUCTIQ IoT Gateway",
        "version": "1.0.0",
        "mqtt_connected": mqtt_client.is_connected(),
        "active_websockets": len(active_connections)
    }


@app.post("/sensor/publish")
async def publish_sensor_data(data: SensorData):
    """Publish sensor data via MQTT"""
    if not data.timestamp:
        data.timestamp = datetime.now().isoformat()
    
    topic = f"constructiq/machines/{data.machine_id}/sensor/{data.sensor_type}"
    payload = data.model_dump_json()
    
    mqtt_client.publish(topic, payload)
    
    return {"status": "published", "topic": topic}


@app.post("/machine/status")
async def publish_machine_status(status: MachineStatus):
    """Publish machine status update"""
    topic = f"constructiq/machines/{status.machine_id}/status"
    payload = status.model_dump_json()

    mqtt_client.publish(topic, payload)

    return {"status": "published", "topic": topic}


@app.post("/machine/command")
async def send_machine_command(command: MachineCommand):
    """Send command to machine via MQTT/PLC"""
    try:
        # Prepare command payload
        payload = {
            "command": command.command,
            "machine_id": command.machine_id,
            "parameters": command.parameters,
            "timestamp": datetime.now().isoformat(),
        }

        # Send via MQTT
        topic = f"{command.mqtt_topic}/command"
        mqtt_client.publish(topic, json.dumps(payload), qos=2)  # QoS 2 for guaranteed delivery

        print(f"Command sent to {topic}: {command.command}")

        # If PLC address is provided, send via PLC protocol (Modbus/OPC UA)
        if command.plc_address:
            # TODO: Implement PLC communication (Modbus TCP, OPC UA, etc.)
            # For now, just log it
            print(f"PLC command to {command.plc_address}: {command.command}")

        return {
            "status": "success",
            "message": f"Command '{command.command}' sent to machine {command.machine_id}",
            "topic": topic,
            "timestamp": payload["timestamp"],
        }

    except Exception as e:
        print(f"Error sending machine command: {e}")
        return {
            "status": "error",
            "message": str(e)
        }


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    """WebSocket endpoint for real-time data streaming"""
    await websocket.accept()
    active_connections.append(websocket)
    
    try:
        while True:
            # Keep connection alive
            await websocket.receive_text()
    except WebSocketDisconnect:
        active_connections.remove(websocket)


@app.on_event("startup")
async def startup_event():
    """Connect to MQTT broker on startup"""
    try:
        mqtt_client.connect(MQTT_BROKER, MQTT_PORT, 60)
        mqtt_client.loop_start()
        print(f"MQTT client started, connecting to {MQTT_BROKER}:{MQTT_PORT}")
    except Exception as e:
        print(f"Failed to connect to MQTT broker: {e}")


@app.on_event("shutdown")
async def shutdown_event():
    """Disconnect from MQTT broker on shutdown"""
    mqtt_client.loop_stop()
    mqtt_client.disconnect()


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8002)

