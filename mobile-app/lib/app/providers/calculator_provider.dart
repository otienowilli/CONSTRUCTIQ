import 'package:flutter/material.dart';
import '../../core/models/calculator_result.dart';
import '../../core/services/calculator_service.dart';
import '../../core/services/api_service.dart';

class CalculatorProvider with ChangeNotifier {
  final CalculatorService _calculatorService = CalculatorService(ApiService());
  CalculatorResult? _currentResult;
  List<CalculatorResult> _history = [];
  bool _isLoading = false;
  String? _error;

  CalculatorResult? get currentResult => _currentResult;
  List<CalculatorResult> get history => _history;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> calculateConcrete({
    required double length,
    required double width,
    required double depth,
    required String grade,
    double wastage = 5.0,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentResult = await _calculatorService.calculateConcrete(
        length: length,
        width: width,
        depth: depth,
        grade: grade,
        wastage: wastage,
      );
      _history.insert(0, _currentResult!);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> calculateBitumen({
    required double length,
    required double width,
    required String grade,
    double applicationRate = 1.2,
    double wastage = 5.0,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentResult = await _calculatorService.calculateBitumen(
        length: length,
        width: width,
        grade: grade,
        applicationRate: applicationRate,
        wastage: wastage,
      );
      _history.insert(0, _currentResult!);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> calculateAsphalt({
    required double length,
    required double width,
    required double thickness,
    required String type,
    double density = 2.4,
    double wastage = 3.0,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentResult = await _calculatorService.calculateAsphalt(
        length: length,
        width: width,
        thickness: thickness,
        type: type,
        density: density,
        wastage: wastage,
      );
      _history.insert(0, _currentResult!);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> calculateGeotextile({
    required double length,
    required double width,
    required String type,
    double overlap = 10.0,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentResult = await _calculatorService.calculateGeotextile(
        length: length,
        width: width,
        type: type,
        overlap: overlap,
      );
      _history.insert(0, _currentResult!);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearResult() {
    _currentResult = null;
    notifyListeners();
  }

  void clearHistory() {
    _history = [];
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
