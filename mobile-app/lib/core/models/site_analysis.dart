class SiteAnalysis {
  final int id;
  final int projectId;
  final String analysisType;
  final Map<String, dynamic> data;
  final String? imagePath;
  final Map<String, dynamic>? recommendations;
  final DateTime analyzedAt;

  SiteAnalysis({
    required this.id,
    required this.projectId,
    required this.analysisType,
    required this.data,
    this.imagePath,
    this.recommendations,
    required this.analyzedAt,
  });

  factory SiteAnalysis.fromJson(Map<String, dynamic> json) {
    return SiteAnalysis(
      id: json['id'] as int,
      projectId: json['project_id'] as int,
      analysisType: json['analysis_type'] as String,
      data: json['data'] as Map<String, dynamic>,
      imagePath: json['image_path'] as String?,
      recommendations: json['recommendations'] as Map<String, dynamic>?,
      analyzedAt: DateTime.parse(json['analyzed_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'analysis_type': analysisType,
      'data': data,
      'image_path': imagePath,
      'recommendations': recommendations,
      'analyzed_at': analyzedAt.toIso8601String(),
    };
  }

  bool get isSoilAnalysis => analysisType.toLowerCase() == 'soil';
  bool get isMaterialAnalysis => analysisType.toLowerCase() == 'material';
}

class SoilAnalysisResult {
  final String soilType;
  final double moistureContent;
  final double phLevel;
  final double compaction;
  final String suitability;
  final List<String> recommendations;

  SoilAnalysisResult({
    required this.soilType,
    required this.moistureContent,
    required this.phLevel,
    required this.compaction,
    required this.suitability,
    required this.recommendations,
  });

  factory SoilAnalysisResult.fromJson(Map<String, dynamic> json) {
    return SoilAnalysisResult(
      soilType: json['soil_type'] as String,
      moistureContent: (json['moisture_content'] as num).toDouble(),
      phLevel: (json['ph_level'] as num).toDouble(),
      compaction: (json['compaction'] as num).toDouble(),
      suitability: json['suitability'] as String,
      recommendations: (json['recommendations'] as List).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'soil_type': soilType,
      'moisture_content': moistureContent,
      'ph_level': phLevel,
      'compaction': compaction,
      'suitability': suitability,
      'recommendations': recommendations,
    };
  }
}
