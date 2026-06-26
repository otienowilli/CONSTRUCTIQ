import 'package:flutter/material.dart';
import '../../core/models/project.dart';
import '../../core/services/api_service.dart';
import '../../core/config/api_config.dart';

class ProjectProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Project> _projects = [];
  Project? _currentProject;
  bool _isLoading = false;
  String? _error;

  List<Project> get projects => _projects;
  Project? get currentProject => _currentProject;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProjects() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiConfig.projects);
      final data = response.data as List;
      _projects = data.map((json) => Project.fromJson(json)).toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProjectDetails(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiConfig.projectDetails(id));
      _currentProject = Project.fromJson(response.data);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createProject({
    required String name,
    required String description,
    required String location,
    required DateTime startDate,
    DateTime? endDate,
    double? latitude,
    double? longitude,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.post(
        ApiConfig.projects,
        data: {
          'name': name,
          'description': description,
          'location': location,
          'start_date': startDate.toIso8601String(),
          if (endDate != null) 'end_date': endDate.toIso8601String(),
          if (latitude != null) 'latitude': latitude,
          if (longitude != null) 'longitude': longitude,
        },
      );
      final newProject = Project.fromJson(response.data);
      _projects.insert(0, newProject);
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

  void setCurrentProject(Project project) {
    _currentProject = project;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
