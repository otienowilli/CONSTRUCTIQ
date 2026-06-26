/// Universal Sensor Code System for All Machines
class SensorCodes {
  // Sensor Types with Standard Codes
  static const Map<String, Map<String, dynamic>> sensorTypes = {
    // Location & Movement
    'GPS': {'code': 'GPS-001', 'description': 'GPS Location Tracker', 'dataType': 'coordinates'},
    'GYRO': {'code': 'GYRO-001', 'description': 'Gyroscope/Orientation', 'dataType': 'degrees'},
    'ACCEL': {'code': 'ACCEL-001', 'description': 'Accelerometer', 'dataType': 'g-force'},
    'SPEED': {'code': 'SPEED-001', 'description': 'Speed Sensor', 'dataType': 'km/h'},
    'DIST': {'code': 'DIST-001', 'description': 'Distance/Proximity Sensor', 'dataType': 'meters'},
    
    // Environmental
    'TEMP': {'code': 'TEMP-001', 'description': 'Temperature Sensor', 'dataType': '°C'},
    'HUMID': {'code': 'HUMID-001', 'description': 'Humidity Sensor', 'dataType': '%'},
    'PRESS': {'code': 'PRESS-001', 'description': 'Pressure Sensor', 'dataType': 'Pa'},
    'VIBR': {'code': 'VIBR-001', 'description': 'Vibration Sensor', 'dataType': 'Hz'},
    'NOISE': {'code': 'NOISE-001', 'description': 'Sound/Noise Level', 'dataType': 'dB'},
    
    // Soil & Material
    'SOIL-MOIST': {'code': 'SOIL-001', 'description': 'Soil Moisture Sensor', 'dataType': '%'},
    'SOIL-PH': {'code': 'SOIL-002', 'description': 'Soil pH Sensor', 'dataType': 'pH'},
    'SOIL-TEMP': {'code': 'SOIL-003', 'description': 'Soil Temperature', 'dataType': '°C'},
    'PENETRO': {'code': 'SOIL-004', 'description': 'Penetrometer/Soil Density', 'dataType': 'MPa'},
    'COMPACT': {'code': 'SOIL-005', 'description': 'Compaction Sensor', 'dataType': '%'},
    
    // Fluid & Flow
    'WATER-LVL': {'code': 'FLUID-001', 'description': 'Water Level Sensor', 'dataType': 'meters'},
    'FLOW': {'code': 'FLUID-002', 'description': 'Flow Meter', 'dataType': 'L/min'},
    'FUEL': {'code': 'FLUID-003', 'description': 'Fuel Level Sensor', 'dataType': 'L'},
    'OIL-PRESS': {'code': 'FLUID-004', 'description': 'Oil Pressure Sensor', 'dataType': 'bar'},
    
    // Load & Force
    'LOAD-CELL': {'code': 'LOAD-001', 'description': 'Load Cell/Weight Sensor', 'dataType': 'kg'},
    'TORQUE': {'code': 'LOAD-002', 'description': 'Torque Sensor', 'dataType': 'Nm'},
    'STRAIN': {'code': 'LOAD-003', 'description': 'Strain Gauge', 'dataType': 'με'},
    
    // Electrical
    'VOLT': {'code': 'ELEC-001', 'description': 'Voltage Sensor', 'dataType': 'V'},
    'CURR': {'code': 'ELEC-002', 'description': 'Current Sensor', 'dataType': 'A'},
    'POWER': {'code': 'ELEC-003', 'description': 'Power Meter', 'dataType': 'W'},
    
    // Optical & Vision
    'CAMERA': {'code': 'VIS-001', 'description': 'Camera/Visual Sensor', 'dataType': 'image'},
    'LIDAR': {'code': 'VIS-002', 'description': 'LiDAR/Laser Scanner', 'dataType': '3D'},
    'INFRARED': {'code': 'VIS-003', 'description': 'Infrared Sensor', 'dataType': 'thermal'},
    
    // Machine Status
    'ENGINE-TEMP': {'code': 'MACH-001', 'description': 'Engine Temperature', 'dataType': '°C'},
    'ENGINE-RPM': {'code': 'MACH-002', 'description': 'Engine RPM', 'dataType': 'rpm'},
    'ENGINE-HOUR': {'code': 'MACH-003', 'description': 'Engine Hours', 'dataType': 'hours'},
    'BATTERY': {'code': 'MACH-004', 'description': 'Battery Level', 'dataType': '%'},
    'HYDRAULIC': {'code': 'MACH-005', 'description': 'Hydraulic Pressure', 'dataType': 'bar'},
    
    // Safety
    'EMERGENCY': {'code': 'SAFE-001', 'description': 'Emergency Stop Sensor', 'dataType': 'boolean'},
    'COLLISION': {'code': 'SAFE-002', 'description': 'Collision Detection', 'dataType': 'boolean'},
    'TILT': {'code': 'SAFE-003', 'description': 'Tilt/Angle Sensor', 'dataType': 'degrees'},
    'BARRIER': {'code': 'SAFE-004', 'description': 'Safety Barrier Sensor', 'dataType': 'boolean'},
  };

  // Get sensor by code
  static Map<String, dynamic>? getSensorByCode(String code) {
    return sensorTypes.values.firstWhere(
      (sensor) => sensor['code'] == code,
      orElse: () => {},
    );
  }

  // Get all sensor codes
  static List<String> getAllSensorCodes() {
    return sensorTypes.values.map((s) => s['code'] as String).toList();
  }

  // Get sensor categories
  static Map<String, List<String>> getSensorCategories() {
    return {
      'Location & Movement': ['GPS', 'GYRO', 'ACCEL', 'SPEED', 'DIST'],
      'Environmental': ['TEMP', 'HUMID', 'PRESS', 'VIBR', 'NOISE'],
      'Soil & Material': ['SOIL-MOIST', 'SOIL-PH', 'SOIL-TEMP', 'PENETRO', 'COMPACT'],
      'Fluid & Flow': ['WATER-LVL', 'FLOW', 'FUEL', 'OIL-PRESS'],
      'Load & Force': ['LOAD-CELL', 'TORQUE', 'STRAIN'],
      'Electrical': ['VOLT', 'CURR', 'POWER'],
      'Optical & Vision': ['CAMERA', 'LIDAR', 'INFRARED'],
      'Machine Status': ['ENGINE-TEMP', 'ENGINE-RPM', 'ENGINE-HOUR', 'BATTERY', 'HYDRAULIC'],
      'Safety': ['EMERGENCY', 'COLLISION', 'TILT', 'BARRIER'],
    };
  }

  // Validate sensor code format
  static bool isValidSensorCode(String code) {
    return RegExp(r'^[A-Z]+-\d{3}$').hasMatch(code);
  }

  // Generate custom sensor code
  static String generateCustomCode(String prefix) {
    return '$prefix-999';
  }
}

/// Machine Command Codes
class MachineCommands {
  static const Map<String, Map<String, dynamic>> commands = {
    'START': {'code': 'CMD-001', 'description': 'Start Machine', 'requiresConfirmation': false},
    'STOP': {'code': 'CMD-002', 'description': 'Stop Machine', 'requiresConfirmation': true},
    'PAUSE': {'code': 'CMD-003', 'description': 'Pause Operation', 'requiresConfirmation': false},
    'RESUME': {'code': 'CMD-004', 'description': 'Resume Operation', 'requiresConfirmation': false},
    'EMERGENCY': {'code': 'CMD-005', 'description': 'Emergency Stop', 'requiresConfirmation': false},
    'RESET': {'code': 'CMD-006', 'description': 'Reset Machine', 'requiresConfirmation': true},
    'CALIBRATE': {'code': 'CMD-007', 'description': 'Calibrate Sensors', 'requiresConfirmation': false},
    'SPEED-UP': {'code': 'CMD-008', 'description': 'Increase Speed', 'requiresConfirmation': false},
    'SPEED-DOWN': {'code': 'CMD-009', 'description': 'Decrease Speed', 'requiresConfirmation': false},
    'MODE-AUTO': {'code': 'CMD-010', 'description': 'Switch to Auto Mode', 'requiresConfirmation': true},
    'MODE-MANUAL': {'code': 'CMD-011', 'description': 'Switch to Manual Mode', 'requiresConfirmation': true},
  };

  // Get command by code
  static Map<String, dynamic>? getCommandByCode(String code) {
    return commands.values.firstWhere(
      (cmd) => cmd['code'] == code,
      orElse: () => {},
    );
  }

  // Check if command requires confirmation
  static bool requiresConfirmation(String commandKey) {
    return commands[commandKey]?['requiresConfirmation'] ?? false;
  }
}
