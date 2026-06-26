/// Comprehensive Construction Materials Database
class MaterialsDatabase {
  // Cement & Binders
  static const List<Map<String, dynamic>> cement = [
    {'name': 'Ordinary Portland Cement (OPC)', 'category': 'Cement', 'unit': 'kg', 'density': 1440},
    {'name': 'Portland Pozzolana Cement (PPC)', 'category': 'Cement', 'unit': 'kg', 'density': 1420},
    {'name': 'Rapid Hardening Cement', 'category': 'Cement', 'unit': 'kg', 'density': 1440},
    {'name': 'White Cement', 'category': 'Cement', 'unit': 'kg', 'density': 1200},
    {'name': 'Low Heat Cement', 'category': 'Cement', 'unit': 'kg', 'density': 1440},
    {'name': 'Sulfate Resisting Cement', 'category': 'Cement', 'unit': 'kg', 'density': 1440},
    {'name': 'Quick Setting Cement', 'category': 'Cement', 'unit': 'kg', 'density': 1440},
    {'name': 'Hydrophobic Cement', 'category': 'Cement', 'unit': 'kg', 'density': 1440},
    {'name': 'Blast Furnace Cement', 'category': 'Cement', 'unit': 'kg', 'density': 1440},
    {'name': 'High Alumina Cement', 'category': 'Cement', 'unit': 'kg', 'density': 1500},
  ];

  // Aggregates
  static const List<Map<String, dynamic>> aggregates = [
    {'name': 'Coarse Sand', 'category': 'Aggregate', 'unit': 'm³', 'density': 1600},
    {'name': 'Fine Sand', 'category': 'Aggregate', 'unit': 'm³', 'density': 1450},
    {'name': 'River Sand', 'category': 'Aggregate', 'unit': 'm³', 'density': 1540},
    {'name': 'Crushed Stone (10mm)', 'category': 'Aggregate', 'unit': 'm³', 'density': 1680},
    {'name': 'Crushed Stone (20mm)', 'category': 'Aggregate', 'unit': 'm³', 'density': 1700},
    {'name': 'Crushed Stone (40mm)', 'category': 'Aggregate', 'unit': 'm³', 'density': 1750},
    {'name': 'Gravel', 'category': 'Aggregate', 'unit': 'm³', 'density': 1520},
    {'name': 'Stone Dust', 'category': 'Aggregate', 'unit': 'm³', 'density': 1650},
    {'name': 'Marble Chips', 'category': 'Aggregate', 'unit': 'm³', 'density': 1600},
    {'name': 'Lightweight Aggregate', 'category': 'Aggregate', 'unit': 'm³', 'density': 800},
  ];

  // Bricks & Blocks
  static const List<Map<String, dynamic>> bricks = [
    {'name': 'Clay Brick (Standard)', 'category': 'Masonry', 'unit': 'pcs', 'size': '230x110x75mm'},
    {'name': 'Clay Brick (Modular)', 'category': 'Masonry', 'unit': 'pcs', 'size': '190x90x90mm'},
    {'name': 'Fly Ash Brick', 'category': 'Masonry', 'unit': 'pcs', 'size': '230x110x75mm'},
    {'name': 'Concrete Block (Hollow)', 'category': 'Masonry', 'unit': 'pcs', 'size': '400x200x200mm'},
    {'name': 'Concrete Block (Solid)', 'category': 'Masonry', 'unit': 'pcs', 'size': '400x200x200mm'},
    {'name': 'AAC Block', 'category': 'Masonry', 'unit': 'pcs', 'size': '600x200x100mm'},
    {'name': 'Calcium Silicate Brick', 'category': 'Masonry', 'unit': 'pcs', 'size': '230x110x75mm'},
    {'name': 'Engineering Brick', 'category': 'Masonry', 'unit': 'pcs', 'size': '230x110x75mm'},
    {'name': 'Fire Brick', 'category': 'Masonry', 'unit': 'pcs', 'size': '230x110x75mm'},
    {'name': 'Glass Block', 'category': 'Masonry', 'unit': 'pcs', 'size': '190x190x80mm'},
  ];

  // Steel & Reinforcement
  static const List<Map<String, dynamic>> steel = [
    {'name': 'TMT Bar 8mm', 'category': 'Steel', 'unit': 'kg', 'diameter': 8},
    {'name': 'TMT Bar 10mm', 'category': 'Steel', 'unit': 'kg', 'diameter': 10},
    {'name': 'TMT Bar 12mm', 'category': 'Steel', 'unit': 'kg', 'diameter': 12},
    {'name': 'TMT Bar 16mm', 'category': 'Steel', 'unit': 'kg', 'diameter': 16},
    {'name': 'TMT Bar 20mm', 'category': 'Steel', 'unit': 'kg', 'diameter': 20},
    {'name': 'TMT Bar 25mm', 'category': 'Steel', 'unit': 'kg', 'diameter': 25},
    {'name': 'TMT Bar 32mm', 'category': 'Steel', 'unit': 'kg', 'diameter': 32},
    {'name': 'Mild Steel Angle', 'category': 'Steel', 'unit': 'kg'},
    {'name': 'Steel I-Beam', 'category': 'Steel', 'unit': 'kg'},
    {'name': 'Steel H-Beam', 'category': 'Steel', 'unit': 'kg'},
    {'name': 'Steel Channel', 'category': 'Steel', 'unit': 'kg'},
    {'name': 'Wire Mesh', 'category': 'Steel', 'unit': 'm²'},
  ];

  // Bitumen & Asphalt
  static const List<Map<String, dynamic>> bitumen = [
    {'name': 'Bitumen 30/40', 'category': 'Bitumen', 'unit': 'L', 'penetration': '30-40'},
    {'name': 'Bitumen 40/50', 'category': 'Bitumen', 'unit': 'L', 'penetration': '40-50'},
    {'name': 'Bitumen 60/70', 'category': 'Bitumen', 'unit': 'L', 'penetration': '60-70'},
    {'name': 'Bitumen 80/100', 'category': 'Bitumen', 'unit': 'L', 'penetration': '80-100'},
    {'name': 'Bitumen 85/100', 'category': 'Bitumen', 'unit': 'L', 'penetration': '85-100'},
    {'name': 'Bitumen 120/150', 'category': 'Bitumen', 'unit': 'L', 'penetration': '120-150'},
    {'name': 'Modified Bitumen (PMB)', 'category': 'Bitumen', 'unit': 'L'},
    {'name': 'Cutback Bitumen', 'category': 'Bitumen', 'unit': 'L'},
    {'name': 'Bitumen Emulsion', 'category': 'Bitumen', 'unit': 'L'},
    {'name': 'Oxidized Bitumen', 'category': 'Bitumen', 'unit': 'L'},
  ];

  static const List<Map<String, dynamic>> asphalt = [
    {'name': 'AC10 (Asphalt Concrete)', 'category': 'Asphalt', 'unit': 'ton', 'density': 2400},
    {'name': 'AC14 (Asphalt Concrete)', 'category': 'Asphalt', 'unit': 'ton', 'density': 2400},
    {'name': 'AC20 (Asphalt Concrete)', 'category': 'Asphalt', 'unit': 'ton', 'density': 2400},
    {'name': 'AC25 (Asphalt Concrete)', 'category': 'Asphalt', 'unit': 'ton', 'density': 2400},
    {'name': 'AC30 (Asphalt Concrete)', 'category': 'Asphalt', 'unit': 'ton', 'density': 2400},
    {'name': 'Dense Bituminous Macadam (DBM)', 'category': 'Asphalt', 'unit': 'ton', 'density': 2400},
    {'name': 'Wet Mix Macadam (WMM)', 'category': 'Asphalt', 'unit': 'ton', 'density': 2200},
    {'name': 'Porous Asphalt', 'category': 'Asphalt', 'unit': 'ton', 'density': 2000},
    {'name': 'Stone Mastic Asphalt (SMA)', 'category': 'Asphalt', 'unit': 'ton', 'density': 2450},
  ];

  // Geotextiles & Membranes
  static const List<Map<String, dynamic>> geotextiles = [
    {'name': 'Woven Geotextile', 'category': 'Geotextile', 'unit': 'm²', 'strength': 'high'},
    {'name': 'Non-Woven Geotextile', 'category': 'Geotextile', 'unit': 'm²', 'strength': 'medium'},
    {'name': 'Knitted Geotextile', 'category': 'Geotextile', 'unit': 'm²', 'strength': 'low'},
    {'name': 'Geogrid', 'category': 'Geotextile', 'unit': 'm²'},
    {'name': 'Geomembrane (HDPE)', 'category': 'Geotextile', 'unit': 'm²'},
    {'name': 'Geocell', 'category': 'Geotextile', 'unit': 'm²'},
    {'name': 'Drainage Mat', 'category': 'Geotextile', 'unit': 'm²'},
    {'name': 'Erosion Control Mat', 'category': 'Geotextile', 'unit': 'm²'},
  ];

  // Get all materials
  static List<Map<String, dynamic>> getAllMaterials() {
    return [
      ...cement,
      ...aggregates,
      ...bricks,
      ...steel,
      ...bitumen,
      ...asphalt,
      ...geotextiles,
    ];
  }

  // Get materials by category
  static List<Map<String, dynamic>> getMaterialsByCategory(String category) {
    return getAllMaterials().where((m) => m['category'] == category).toList();
  }

  // Get all categories
  static List<String> getAllCategories() {
    return [
      'Cement',
      'Aggregate',
      'Masonry',
      'Steel',
      'Bitumen',
      'Asphalt',
      'Geotextile',
    ];
  }
}
