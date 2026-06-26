class Report {
  final int id;
  final String title;
  final String type;
  final int projectId;
  final int userId;
  final Map<String, dynamic> data;
  final String? filePath;
  final DateTime generatedAt;

  Report({
    required this.id,
    required this.title,
    required this.type,
    required this.projectId,
    required this.userId,
    required this.data,
    this.filePath,
    required this.generatedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as int,
      title: json['title'] as String,
      type: json['type'] as String,
      projectId: json['project_id'] as int,
      userId: json['user_id'] as int,
      data: json['data'] as Map<String, dynamic>,
      filePath: json['file_path'] as String?,
      generatedAt: DateTime.parse(json['generated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'project_id': projectId,
      'user_id': userId,
      'data': data,
      'file_path': filePath,
      'generated_at': generatedAt.toIso8601String(),
    };
  }

  String get typeIcon {
    switch (type.toLowerCase()) {
      case 'material_calculation':
        return '🧮';
      case 'project_summary':
        return '📊';
      case 'cost_estimate':
        return '💰';
      case 'daily_report':
        return '📅';
      case 'weekly_report':
        return '📈';
      case 'machine_log':
        return '🤖';
      case 'sensor_data':
        return '📡';
      default:
        return '📄';
    }
  }
}
