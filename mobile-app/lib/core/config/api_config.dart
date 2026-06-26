/// API Configuration
class ApiConfig {
  // Base URLs
  static const String baseUrl = 'http://localhost:8000'; // Change for production
  static const String apiBaseUrl = '$baseUrl/api';
  static const String aiEngineUrl = 'http://localhost:8001';
  static const String iotGatewayUrl = 'http://localhost:8002';
  
  // API Endpoints
  static const String login = '$apiBaseUrl/login';
  static const String register = '$apiBaseUrl/register';
  static const String logout = '$apiBaseUrl/logout';
  static const String user = '$apiBaseUrl/user';
  static const String refreshToken = '$apiBaseUrl/refresh';
  
  // Projects
  static const String projects = '$apiBaseUrl/projects';
  static String projectDetails(int id) => '$projects/$id';
  
  // Materials
  static const String materials = '$apiBaseUrl/materials';
  static String materialsByCategory(String category) => '$materials?category=$category';
  
  // Calculators
  static const String calculators = '$apiBaseUrl/calculate';
  static const String concreteCalculator = '$calculators/concrete';
  static const String bitumenCalculator = '$calculators/bitumen';
  static const String asphaltCalculator = '$calculators/asphalt';
  static const String geotextileCalculator = '$calculators/geotextile';
  static const String brickworkCalculator = '$calculators/brickwork';
  static const String plasteringCalculator = '$calculators/plastering';
  static const String paintingCalculator = '$calculators/painting';
  static const String excavationCalculator = '$calculators/excavation';
  static const String roadCalculator = '$calculators/road';
  static const String roofingCalculator = '$calculators/roofing';
  
  // Machines
  static const String machines = '$apiBaseUrl/machines';
  static String machineDetails(int id) => '$machines/$id';
  static String machineCommand(int id) => '$machines/$id/command';
  static String machineSensors(int id) => '$machines/$id/sensors';
  static String machineHistory(int id) => '$machines/$id/history';
  
  // Site Analysis
  static const String siteAnalysis = '$apiBaseUrl/site-analysis';
  static const String soilAnalysis = '$aiEngineUrl/analyze-soil';
  
  // Reports
  static const String reports = '$apiBaseUrl/reports';
  static String generateReport(int projectId) => '$reports/generate/$projectId';
  
  // Chat
  static const String chat = '$apiBaseUrl/chat';
  static const String chatMessages = '$chat/messages';
  
  // IoT Gateway
  static const String iotSensors = '$iotGatewayUrl/sensors';
  static const String iotCommand = '$iotGatewayUrl/command';
  
  // API Settings
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000;
  
  // Headers
  static Map<String, String> headers({String? token}) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };
  
  // Production URLs (update when deploying)
  static const String productionBaseUrl = 'https://api.constructiq.com';
  static const String productionAiUrl = 'https://ai.constructiq.com';
  static const String productionIotUrl = 'https://iot.constructiq.com';
  
  // Environment check
  static bool get isProduction => 
      const bool.fromEnvironment('dart.vm.product', defaultValue: false);
  
  static String get currentBaseUrl => 
      isProduction ? productionBaseUrl : baseUrl;
}
