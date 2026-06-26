class CalculatorResult {
  final String calculatorType;
  final Map<String, dynamic> inputs;
  final Map<String, dynamic> results;
  final double? totalCost;
  final String? currency;
  final DateTime calculatedAt;

  CalculatorResult({
    required this.calculatorType,
    required this.inputs,
    required this.results,
    this.totalCost,
    this.currency,
    DateTime? calculatedAt,
  }) : calculatedAt = calculatedAt ?? DateTime.now();

  factory CalculatorResult.fromJson(Map<String, dynamic> json) {
    return CalculatorResult(
      calculatorType: json['calculator_type'] as String? ?? json['type'] as String,
      inputs: json['inputs'] as Map<String, dynamic>,
      results: json['results'] as Map<String, dynamic>,
      totalCost: json['total_cost'] != null ? (json['total_cost'] as num).toDouble() : null,
      currency: json['currency'] as String?,
      calculatedAt: json['calculated_at'] != null
          ? DateTime.parse(json['calculated_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calculator_type': calculatorType,
      'inputs': inputs,
      'results': results,
      'total_cost': totalCost,
      'currency': currency,
      'calculated_at': calculatedAt.toIso8601String(),
    };
  }

  String get displayName {
    switch (calculatorType.toLowerCase()) {
      case 'concrete':
        return 'Concrete Calculator';
      case 'bitumen':
        return 'Bitumen Calculator';
      case 'asphalt':
        return 'Asphalt Calculator';
      case 'geotextile':
        return 'Geotextile Calculator';
      case 'brickwork':
        return 'Brickwork Calculator';
      case 'plastering':
        return 'Plastering Calculator';
      case 'painting':
        return 'Painting Calculator';
      case 'excavation':
        return 'Excavation Calculator';
      case 'road':
        return 'Road Calculator';
      case 'roofing':
        return 'Roofing Calculator';
      default:
        return 'Calculator';
    }
  }

  String get formattedCost {
    if (totalCost == null) return 'N/A';
    final curr = currency ?? 'KES';
    return '$curr ${totalCost!.toStringAsFixed(2)}';
  }
}

// Specific calculator result models
class BitumenCalculatorResult extends CalculatorResult {
  BitumenCalculatorResult({
    required Map<String, dynamic> inputs,
    required double area,
    required double bitumenRequired,
    required double totalWithWastage,
    required String unit,
    required String grade,
    required double applicationRate,
    required double pricePerLiter,
    required double totalCost,
  }) : super(
          calculatorType: 'bitumen',
          inputs: inputs,
          results: {
            'area': area,
            'bitumen_required': bitumenRequired,
            'total_with_wastage': totalWithWastage,
            'unit': unit,
            'grade': grade,
            'application_rate': applicationRate,
            'price_per_liter': pricePerLiter,
          },
          totalCost: totalCost,
          currency: 'KES',
        );
}

class AsphaltCalculatorResult extends CalculatorResult {
  AsphaltCalculatorResult({
    required Map<String, dynamic> inputs,
    required double volume,
    required double weight,
    required double totalWithWastage,
    required String unit,
    required String type,
    required double density,
    required double thickness,
    required double pricePerTon,
    required double totalCost,
  }) : super(
          calculatorType: 'asphalt',
          inputs: inputs,
          results: {
            'volume': volume,
            'weight': weight,
            'total_with_wastage': totalWithWastage,
            'unit': unit,
            'type': type,
            'density': density,
            'thickness': thickness,
            'price_per_ton': pricePerTon,
          },
          totalCost: totalCost,
          currency: 'KES',
        );
}
