class Material {
  final int id;
  final String name;
  final String category;
  final String unit;
  final double price;
  final String? description;
  final Map<String, dynamic>? specifications;
  final DateTime createdAt;
  final DateTime updatedAt;

  Material({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    required this.price,
    this.description,
    this.specifications,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      unit: json['unit'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String?,
      specifications: json['specifications'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'unit': unit,
      'price': price,
      'description': description,
      'specifications': specifications,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get formattedPrice => 'KES ${price.toStringAsFixed(2)} per $unit';
}

class MaterialUsage {
  final int id;
  final int projectId;
  final int materialId;
  final Material? material;
  final double quantity;
  final double totalCost;
  final DateTime usedAt;

  MaterialUsage({
    required this.id,
    required this.projectId,
    required this.materialId,
    this.material,
    required this.quantity,
    required this.totalCost,
    required this.usedAt,
  });

  factory MaterialUsage.fromJson(Map<String, dynamic> json) {
    return MaterialUsage(
      id: json['id'] as int,
      projectId: json['project_id'] as int,
      materialId: json['material_id'] as int,
      material: json['material'] != null ? Material.fromJson(json['material']) : null,
      quantity: (json['quantity'] as num).toDouble(),
      totalCost: (json['total_cost'] as num).toDouble(),
      usedAt: DateTime.parse(json['used_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_id': projectId,
      'material_id': materialId,
      'quantity': quantity,
      'total_cost': totalCost,
      'used_at': usedAt.toIso8601String(),
    };
  }
}
