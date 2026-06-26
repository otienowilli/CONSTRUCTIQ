class SensorData {
  final int id;
  final int machineId;
  final String sensorType;
  final double value;
  final String unit;
  final String status;
  final DateTime timestamp;

  SensorData({
    required this.id,
    required this.machineId,
    required this.sensorType,
    required this.value,
    required this.unit,
    required this.status,
    required this.timestamp,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      id: json['id'] as int,
      machineId: json['machine_id'] as int,
      sensorType: json['sensor_type'] as String,
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String,
      status: json['status'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'machine_id': machineId,
      'sensor_type': sensorType,
      'value': value,
      'unit': unit,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  bool get isNormal => status.toLowerCase() == 'normal';
  bool get isWarning => status.toLowerCase() == 'warning';
  bool get isCritical => status.toLowerCase() == 'critical';

  String get statusIcon {
    if (isNormal) return '🟢';
    if (isWarning) return '🟡';
    if (isCritical) return '🔴';
    return '⚪';
  }

  String get formattedValue => '${value.toStringAsFixed(2)} $unit';
}

class LocationData {
  final double latitude;
  final double longitude;
  final double? altitude;
  final double? accuracy;
  final double? speed;
  final DateTime timestamp;

  LocationData({
    required this.latitude,
    required this.longitude,
    this.altitude,
    this.accuracy,
    this.speed,
    required this.timestamp,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      altitude: json['altitude'] != null ? (json['altitude'] as num).toDouble() : null,
      accuracy: json['accuracy'] != null ? (json['accuracy'] as num).toDouble() : null,
      speed: json['speed'] != null ? (json['speed'] as num).toDouble() : null,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'accuracy': accuracy,
      'speed': speed,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  String get coordinates => '$latitude, $longitude';
  
  bool get isHighAccuracy => accuracy != null && accuracy! < 10;
}
