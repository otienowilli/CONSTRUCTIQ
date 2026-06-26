import '../models/calculator_result.dart';
import '../config/api_config.dart';
import 'api_service.dart';

class CalculatorService {
  final ApiService _apiService;

  CalculatorService(this._apiService);

  // Concrete Calculator
  Future<CalculatorResult> calculateConcrete({
    required double length,
    required double width,
    required double depth,
    required String grade,
    double wastage = 5.0,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConfig.concreteCalculator,
        data: {
          'length': length,
          'width': width,
          'depth': depth,
          'grade': grade,
          'wastage_percentage': wastage,
        },
      );
      return CalculatorResult.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Bitumen Calculator
  Future<CalculatorResult> calculateBitumen({
    required double length,
    required double width,
    required String grade,
    double applicationRate = 1.2,
    double wastage = 5.0,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConfig.bitumenCalculator,
        data: {
          'length': length,
          'width': width,
          'grade': grade,
          'application_rate': applicationRate,
          'wastage_percentage': wastage,
        },
      );
      return CalculatorResult.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Asphalt Calculator
  Future<CalculatorResult> calculateAsphalt({
    required double length,
    required double width,
    required double thickness,
    required String type,
    double density = 2.4,
    double wastage = 3.0,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConfig.asphaltCalculator,
        data: {
          'length': length,
          'width': width,
          'thickness': thickness,
          'type': type,
          'density': density,
          'wastage_percentage': wastage,
        },
      );
      return CalculatorResult.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Geotextile Calculator
  Future<CalculatorResult> calculateGeotextile({
    required double length,
    required double width,
    required String type,
    double overlap = 10.0,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConfig.geotextileCalculator,
        data: {
          'length': length,
          'width': width,
          'type': type,
          'overlap_percentage': overlap,
        },
      );
      return CalculatorResult.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Brickwork Calculator
  Future<CalculatorResult> calculateBrickwork({
    required double length,
    required double height,
    required double wallThickness,
    String brickSize = 'standard',
  }) async {
    try {
      final response = await _apiService.post(
        ApiConfig.brickworkCalculator,
        data: {
          'length': length,
          'height': height,
          'wall_thickness': wallThickness,
          'brick_size': brickSize,
        },
      );
      return CalculatorResult.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Generic calculator call
  Future<CalculatorResult> calculate(
    String calculatorType,
    Map<String, dynamic> inputs,
  ) async {
    try {
      final endpoint = '${ApiConfig.calculators}/$calculatorType';
      final response = await _apiService.post(endpoint, data: inputs);
      return CalculatorResult.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
