/// Application Constants
class AppConstants {
  // Material Types
  static const List<String> materialCategories = [
    'Civil',
    'Roads',
    'Finishing',
    'Plumbing',
    'Electrical',
    'Structural',
    'Bitumen',
    'Asphalt',
    'Geotextiles',
    'Prefabricated',
    'Admixtures',
    'Recycled',
  ];
  
  // Calculator Types
  static const List<Map<String, dynamic>> calculators = [
    {
      'id': 'concrete',
      'name': 'Concrete Calculator',
      'icon': '🏗️',
      'description': 'Calculate concrete volume and materials',
    },
    {
      'id': 'bitumen',
      'name': 'Bitumen Calculator',
      'icon': '🛣️',
      'description': 'Calculate bitumen application rates',
      'isNew': true,
    },
    {
      'id': 'asphalt',
      'name': 'Asphalt Calculator',
      'icon': '🛣️',
      'description': 'Calculate asphalt weight and volume',
      'isNew': true,
    },
    {
      'id': 'geotextile',
      'name': 'Geotextile Calculator',
      'icon': '📐',
      'description': 'Calculate geotextile area with overlap',
      'isNew': true,
    },
    {
      'id': 'brickwork',
      'name': 'Brickwork Calculator',
      'icon': '🧱',
      'description': 'Calculate bricks and mortar',
    },
    {
      'id': 'plastering',
      'name': 'Plastering Calculator',
      'icon': '🏠',
      'description': 'Calculate cement and sand for plastering',
    },
    {
      'id': 'painting',
      'name': 'Painting Calculator',
      'icon': '🎨',
      'description': 'Calculate paint and primer required',
    },
    {
      'id': 'excavation',
      'name': 'Excavation Calculator',
      'icon': '⛏️',
      'description': 'Calculate excavation volume',
    },
    {
      'id': 'road',
      'name': 'Road Calculator',
      'icon': '🛣️',
      'description': 'Calculate road materials',
    },
    {
      'id': 'roofing',
      'name': 'Roofing Calculator',
      'icon': '🏚️',
      'description': 'Calculate roofing materials',
    },
  ];
  
  // User Roles
  static const List<String> userRoles = [
    'Admin',
    'Engineer',
    'Contractor',
    'Site Manager',
    'Worker',
    'Supervisor',
  ];
  
  // Machine Types
  static const List<String> machineTypes = [
    'Concrete Mixer',
    'Batching Plant',
    'Asphalt Mixer',
    'Bitumen Plant',
    'Crusher',
    'Roller',
    'Excavator',
    'Loader',
    'Pump',
    'Compactor',
    'Paver',
    'Grader',
    'Dozer',
  ];
  
  // Sensor Types
  static const List<String> sensorTypes = [
    'GPS',
    'Camera',
    'Accelerometer',
    'Gyroscope',
    'Soil Moisture',
    'Soil pH',
    'Penetrometer',
    'Water Level',
    'Flow Meter',
    'Load Cell',
    'Temperature',
    'Vibration',
    'Pressure',
    'Humidity',
  ];
  
  // Machine Commands
  static const List<String> machineCommands = [
    'start',
    'stop',
    'pause',
    'resume',
    'emergency_stop',
  ];
  
  // Report Types
  static const List<String> reportTypes = [
    'Material Calculation',
    'Project Summary',
    'Cost Estimate',
    'Daily Report',
    'Weekly Report',
    'Machine Log',
    'Sensor Data',
  ];
  
  // Units of Measurement
  static const Map<String, List<String>> units = {
    'length': ['m', 'cm', 'mm', 'ft', 'in'],
    'area': ['m²', 'ft²', 'hectare', 'acre'],
    'volume': ['m³', 'L', 'ft³', 'gal'],
    'weight': ['kg', 'g', 'ton', 'lb'],
    'temperature': ['°C', '°F', 'K'],
    'pressure': ['Pa', 'kPa', 'MPa', 'psi'],
  };
  
  // Default Values
  static const Map<String, dynamic> defaults = {
    'concreteGrade': 'C25',
    'bitumenGrade': '80/100',
    'asphaltType': 'AC14',
    'geotextileType': 'woven',
    'wastagePercentage': 5.0,
    'currency': 'KES',
  };
}
