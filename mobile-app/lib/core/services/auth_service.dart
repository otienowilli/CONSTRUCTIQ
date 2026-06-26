import '../models/user.dart';
import '../config/api_config.dart';
import 'api_service.dart';
import 'storage_service.dart';

class AuthService {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthService(this._apiService, this._storageService);

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        ApiConfig.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final token = data['token'] as String;
      final user = User.fromJson(data['user']);

      // Save token and user data
      await _storageService.saveToken(token);
      await _storageService.saveUser(user);
      _apiService.setToken(token);

      return {
        'token': token,
        'user': user,
      };
    } catch (e) {
      rethrow;
    }
  }

  // Register
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String role,
    String? phone,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConfig.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
          'role': role,
          if (phone != null) 'phone': phone,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final token = data['token'] as String;
      final user = User.fromJson(data['user']);

      // Save token and user data
      await _storageService.saveToken(token);
      await _storageService.saveUser(user);
      _apiService.setToken(token);

      return {
        'token': token,
        'user': user,
      };
    } catch (e) {
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _apiService.post(ApiConfig.logout);
    } catch (e) {
      // Continue even if API call fails
    } finally {
      await _storageService.clearToken();
      await _storageService.clearUser();
      _apiService.clearToken();
    }
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    try {
      final user = await _storageService.getUser();
      if (user != null) {
        final token = await _storageService.getToken();
        if (token != null) {
          _apiService.setToken(token);
          
          // Fetch fresh user data
          final response = await _apiService.get(ApiConfig.user);
          final freshUser = User.fromJson(response.data);
          await _storageService.saveUser(freshUser);
          return freshUser;
        }
      }
      return user;
    } catch (e) {
      return null;
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await _storageService.getToken();
    return token != null;
  }

  // Refresh token
  Future<String?> refreshToken() async {
    try {
      final response = await _apiService.post(ApiConfig.refreshToken);
      final token = response.data['token'] as String;
      await _storageService.saveToken(token);
      _apiService.setToken(token);
      return token;
    } catch (e) {
      return null;
    }
  }
}
