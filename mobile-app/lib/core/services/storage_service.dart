import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../config/app_config.dart';

class StorageService {
  late SharedPreferences _prefs;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  // Token management
  Future<void> saveToken(String token) async {
    await init();
    await _prefs.setString(AppConfig.keyAuthToken, token);
  }

  Future<String?> getToken() async {
    await init();
    return _prefs.getString(AppConfig.keyAuthToken);
  }

  Future<void> clearToken() async {
    await init();
    await _prefs.remove(AppConfig.keyAuthToken);
  }

  // User management
  Future<void> saveUser(User user) async {
    await init();
    await _prefs.setString(AppConfig.keyUserData, jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    await init();
    final userJson = _prefs.getString(AppConfig.keyUserData);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> clearUser() async {
    await init();
    await _prefs.remove(AppConfig.keyUserData);
  }

  // Theme management
  Future<void> saveThemeMode(String mode) async {
    await init();
    await _prefs.setString(AppConfig.keyThemeMode, mode);
  }

  Future<String?> getThemeMode() async {
    await init();
    return _prefs.getString(AppConfig.keyThemeMode);
  }

  // Language
  Future<void> saveLanguage(String language) async {
    await init();
    await _prefs.setString(AppConfig.keyLanguage, language);
  }

  Future<String?> getLanguage() async {
    await init();
    return _prefs.getString(AppConfig.keyLanguage);
  }

  // Onboarding
  Future<void> setOnboardingComplete() async {
    await init();
    await _prefs.setBool(AppConfig.keyOnboardingComplete, true);
  }

  Future<bool> isOnboardingComplete() async {
    await init();
    return _prefs.getBool(AppConfig.keyOnboardingComplete) ?? false;
  }

  // Biometric
  Future<void> setBiometricEnabled(bool enabled) async {
    await init();
    await _prefs.setBool(AppConfig.keyBiometricEnabled, enabled);
  }

  Future<bool> isBiometricEnabled() async {
    await init();
    return _prefs.getBool(AppConfig.keyBiometricEnabled) ?? false;
  }

  // Offline mode
  Future<void> setOfflineMode(bool enabled) async {
    await init();
    await _prefs.setBool(AppConfig.keyOfflineMode, enabled);
  }

  Future<bool> isOfflineMode() async {
    await init();
    return _prefs.getBool(AppConfig.keyOfflineMode) ?? false;
  }

  // Generic save/get
  Future<void> save(String key, dynamic value) async {
    await init();
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else {
      await _prefs.setString(key, jsonEncode(value));
    }
  }

  Future<dynamic> get(String key) async {
    await init();
    return _prefs.get(key);
  }

  Future<void> remove(String key) async {
    await init();
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await init();
    await _prefs.clear();
  }
}
