/// Comprehensive Construction Machines Database
class MachinesDatabase {
  // Earthmoving Equipment
  static const List<Map<String, dynamic>> earthmoving = [
    {'name': 'Bulldozer', 'category': 'Earthmoving', 'power': 'Diesel', 'capacity': 'various'},
    {'name': 'Excavator (Mini)', 'category': 'Earthmoving', 'power': 'Diesel/Electric', 'capacity': '1-6 ton'},
    {'name': 'Excavator (Medium)', 'category': 'Earthmoving', 'power': 'Diesel', 'capacity': '7-45 ton'},
    {'name': 'Excavator (Heavy)', 'category': 'Earthmoving', 'power': 'Diesel', 'capacity': '46+ ton'},
    {'name': 'Backhoe Loader', 'category': 'Earthmoving', 'power': 'Diesel', 'capacity': 'various'},
    {'name': 'Wheel Loader', 'category': 'Earthmoving', 'power': 'Diesel', 'capacity': 'various'},
    {'name': 'Skid Steer Loader', 'category': 'Earthmoving', 'power': 'Diesel/Electric', 'capacity': 'various'},
    {'name': 'Motor Grader', 'category': 'Earthmoving', 'power': 'Diesel', 'capacity': 'various'},
    {'name': 'Trencher', 'category': 'Earthmoving', 'power': 'Diesel/Electric', 'capacity': 'various'},
    {'name': 'Scraper', 'category': 'Earthmoving', 'power': 'Diesel', 'capacity': 'various'},
  ];

  // Concrete Equipment
  static const List<Map<String, dynamic>> concrete = [
    {'name': 'Concrete Mixer (Drum)', 'category': 'Concrete', 'power': 'Electric/Diesel', 'capacity': '50-500L'},
    {'name': 'Concrete Mixer (Pan)', 'category': 'Concrete', 'power': 'Electric', 'capacity': '100-1000L'},
    {'name': 'Batching Plant (Mobile)', 'category': 'Concrete', 'power': 'Diesel', 'capacity': '30-60 m³/hr'},
    {'name': 'Batching Plant (Stationary)', 'category': 'Concrete', 'power': 'Electric', 'capacity': '60-120 m³/hr'},
    {'name': 'Concrete Pump (Boom)', 'category': 'Concrete', 'power': 'Diesel', 'capacity': '20-60m reach'},
    {'name': 'Concrete Pump (Line)', 'category': 'Concrete', 'power': 'Electric/Diesel', 'capacity': 'various'},
    {'name': 'Transit Mixer', 'category': 'Concrete', 'power': 'Diesel', 'capacity': '6-10 m³'},
    {'name': 'Concrete Vibrator', 'category': 'Concrete', 'power': 'Electric/Petrol', 'capacity': 'various'},
    {'name': 'Power Trowel', 'category': 'Concrete', 'power': 'Petrol/Electric', 'capacity': 'various'},
    {'name': 'Concrete Saw', 'category': 'Concrete', 'power': 'Petrol/Electric', 'capacity': 'various'},
  ];

  // Road Construction Equipment
  static const List<Map<String, dynamic>> road = [
    {'name': 'Asphalt Plant (Mobile)', 'category': 'Road', 'power': 'Diesel', 'capacity': '80-160 ton/hr'},
    {'name': 'Asphalt Plant (Stationary)', 'category': 'Road', 'power': 'Electric', 'capacity': '120-320 ton/hr'},
    {'name': 'Asphalt Paver (Tracked)', 'category': 'Road', 'power': 'Diesel', 'capacity': '2-12m width'},
    {'name': 'Asphalt Paver (Wheeled)', 'category': 'Road', 'power': 'Diesel', 'capacity': '2-12m width'},
    {'name': 'Road Roller (Single Drum)', 'category': 'Road', 'power': 'Diesel', 'capacity': '6-18 ton'},
    {'name': 'Road Roller (Double Drum)', 'category': 'Road', 'power': 'Diesel', 'capacity': '1-12 ton'},
    {'name': 'Road Roller (Pneumatic)', 'category': 'Road', 'power': 'Diesel', 'capacity': '8-27 ton'},
    {'name': 'Bitumen Sprayer', 'category': 'Road', 'power': 'Diesel', 'capacity': '1000-5000L'},
    {'name': 'Slurry Seal Machine', 'category': 'Road', 'power': 'Diesel', 'capacity': 'various'},
    {'name': 'Cold Planer/Milling Machine', 'category': 'Road', 'power': 'Diesel', 'capacity': 'various'},
    {'name': 'Road Marking Machine', 'category': 'Road', 'power': 'Petrol/Electric', 'capacity': 'various'},
  ];

  // Compaction Equipment
  static const List<Map<String, dynamic>> compaction = [
    {'name': 'Plate Compactor', 'category': 'Compaction', 'power': 'Petrol/Electric', 'capacity': 'various'},
    {'name': 'Rammer/Tamper', 'category': 'Compaction', 'power': 'Petrol/Electric', 'capacity': 'various'},
    {'name': 'Vibratory Roller', 'category': 'Compaction', 'power': 'Diesel', 'capacity': 'various'},
    {'name': 'Sheepsfoot Roller', 'category': 'Compaction', 'power': 'Diesel', 'capacity': 'various'},
    {'name': 'Smooth Wheel Roller', 'category': 'Compaction', 'power': 'Diesel', 'capacity': 'various'},
  ];

  // Crushing & Screening
  static const List<Map<String, dynamic>> crushing = [
    {'name': 'Jaw Crusher', 'category': 'Crushing', 'power': 'Diesel/Electric', 'capacity': '50-800 ton/hr'},
    {'name': 'Cone Crusher', 'category': 'Crushing', 'power': 'Electric', 'capacity': '50-1000 ton/hr'},
    {'name': 'Impact Crusher', 'category': 'Crushing', 'power': 'Electric', 'capacity': '30-500 ton/hr'},
    {'name': 'Mobile Crusher', 'category': 'Crushing', 'power': 'Diesel', 'capacity': '100-400 ton/hr'},
    {'name': 'Vibrating Screen', 'category': 'Crushing', 'power': 'Electric', 'capacity': 'various'},
    {'name': 'Trommel Screen', 'category': 'Crushing', 'power': 'Electric/Diesel', 'capacity': 'various'},
  ];

  // Material Handling
  static const List<Map<String, dynamic>> handling = [
    {'name': 'Tower Crane', 'category': 'Handling', 'power': 'Electric', 'capacity': '4-80 ton'},
    {'name': 'Mobile Crane', 'category': 'Handling', 'power': 'Diesel', 'capacity': '10-1200 ton'},
    {'name': 'Forklift', 'category': 'Handling', 'power': 'Electric/Diesel/LPG', 'capacity': '1-10 ton'},
    {'name': 'Telehandler', 'category': 'Handling', 'power': 'Diesel', 'capacity': '2-6 ton'},
    {'name': 'Conveyor Belt', 'category': 'Handling', 'power': 'Electric', 'capacity': 'various'},
    {'name': 'Hoist', 'category': 'Handling', 'power': 'Electric', 'capacity': '0.5-50 ton'},
  ];

  // Piling Equipment
  static const List<Map<String, dynamic>> piling = [
    {'name': 'Pile Driver', 'category': 'Piling', 'power': 'Diesel', 'capacity': 'various'},
    {'name': 'Rotary Drilling Rig', 'category': 'Piling', 'power': 'Diesel', 'capacity': 'various'},
    {'name': 'CFA (Continuous Flight Auger)', 'category': 'Piling', 'power': 'Diesel', 'capacity': 'various'},
    {'name': 'Hydraulic Pile Breaker', 'category': 'Piling', 'power': 'Hydraulic', 'capacity': 'various'},
  ];

  // Generators & Compressors
  static const List<Map<String, dynamic>> power = [
    {'name': 'Diesel Generator (Portable)', 'category': 'Power', 'power': 'Diesel', 'capacity': '5-50 kVA'},
    {'name': 'Diesel Generator (Stationary)', 'category': 'Power', 'power': 'Diesel', 'capacity': '50-3000 kVA'},
    {'name': 'Air Compressor (Portable)', 'category': 'Power', 'power': 'Diesel/Electric', 'capacity': '100-400 CFM'},
    {'name': 'Air Compressor (Stationary)', 'category': 'Power', 'power': 'Electric', 'capacity': '100-1000 CFM'},
    {'name': 'Welding Machine', 'category': 'Power', 'power': 'Electric/Diesel', 'capacity': 'various'},
  ];

  // Get all machines
  static List<Map<String, dynamic>> getAllMachines() {
    return [
      ...earthmoving,
      ...concrete,
      ...road,
      ...compaction,
      ...crushing,
      ...handling,
      ...piling,
      ...power,
    ];
  }

  // Get machines by category
  static List<Map<String, dynamic>> getMachinesByCategory(String category) {
    return getAllMachines().where((m) => m['category'] == category).toList();
  }

  // Get all categories
  static List<String> getAllCategories() {
    return [
      'Earthmoving',
      'Concrete',
      'Road',
      'Compaction',
      'Crushing',
      'Handling',
      'Piling',
      'Power',
    ];
  }
}
