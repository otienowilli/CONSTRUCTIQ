import 'package:flutter/material.dart';
import '../../core/models/machine.dart';
import '../../core/models/sensor_data.dart';
import '../../core/services/api_service.dart';
import '../../core/config/api_config.dart';

class MachineProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Machine> _machines = [];
  Machine? _currentMachine;
  List<SensorData> _sensorData = [];
  bool _isLoading = false;
  String? _error;

  List<Machine> get machines => _machines;
  Machine? get currentMachine => _currentMachine;
  List<SensorData> get sensorData => _sensorData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMachines() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiConfig.machines);
      final data = response.data as List;
      _machines = data.map((json) => Machine.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMachineDetails(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiConfig.machineDetails(id));
      _currentMachine = Machine.fromJson(response.data);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSensorData(int machineId) async {
    try {
      final response = await _apiService.get(ApiConfig.machineSensors(machineId));
      final data = response.data as List;
      _sensorData = data.map((json) => SensorData.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> sendCommand(int machineId, String command, {Map<String, dynamic>? parameters}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _apiService.post(
        ApiConfig.machineCommand(machineId),
        data: {
          'command': command,
          if (parameters != null) 'parameters': parameters,
        },
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void setCurrentMachine(Machine machine) {
    _currentMachine = machine;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
