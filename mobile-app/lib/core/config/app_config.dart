/// Application Configuration
class AppConfig {
  // App Information
  static const String appName = 'CONSTRUCTIQ';
  static const String appVersion = '2.0.0';
  static const String appDescription = 
      'AI-powered construction field intelligence and smart material optimization platform';
  
  // Package Info
  static const String androidPackage = 'com.constructiq.app';
  static const String iosBundle = 'com.constructiq.app';
  
  // API Keys (Add your actual keys)
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  static const String firebaseProjectId = 'constructiq-app';
  
  // Feature Flags
  static const bool enableOfflineMode = true;
  static const bool enablePushNotifications = true;
  static const bool enableCrashReporting = true;
  static const bool enableAnalytics = true;
  static const bool enableBiometricAuth = true;
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Cache Duration
  static const Duration cacheDuration = Duration(hours: 24);
  static const Duration tokenRefreshDuration = Duration(minutes: 55);
  
  // Storage Keys
  static const String keyAuthToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserData = 'user_data';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyOnboardingComplete = 'onboarding_complete';
  static const String keyBiometricEnabled = 'biometric_enabled';
  static const String keyOfflineMode = 'offline_mode';
  
  // Validation Rules
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  
  // File Upload
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxPdfSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'webp'];
  static const List<String> allowedDocTypes = ['pdf', 'doc', 'docx'];
  
  // Map Settings
  static const double defaultZoom = 15.0;
  static const double minZoom = 5.0;
  static const double maxZoom = 20.0;
  static const double defaultLatitude = -1.286389; // Nairobi
  static const double defaultLongitude = 36.817223;
  
  // Sensor Settings
  static const Duration sensorUpdateInterval = Duration(seconds: 5);
  static const Duration gpsUpdateInterval = Duration(seconds: 10);
  
  // Sync Settings
  static const Duration syncInterval = Duration(minutes: 15);
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 5);
  
  // Support
  static const String supportEmail = 'support@constructiq.com';
  static const String supportPhone = '+254700000000';
  static const String websiteUrl = 'https://constructiq.com';
  static const String privacyPolicyUrl = 'https://constructiq.com/privacy';
  static const String termsUrl = 'https://constructiq.com/terms';
  
  // Social Media
  static const String facebookUrl = 'https://facebook.com/constructiq';
  static const String twitterUrl = 'https://twitter.com/constructiq';
  static const String linkedinUrl = 'https://linkedin.com/company/constructiq';
  
  // Build Info
  static const String buildNumber = '1';
  static const String buildDate = '2026-06-26';
}
