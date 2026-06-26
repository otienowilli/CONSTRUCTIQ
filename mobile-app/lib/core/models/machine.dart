class Machine {
  final int id;
  final String name;
  final String type;
  final String status;
  final Map<String, dynamic>? specifications;
  final DateTime? lastMaintenance;
  final int? projectId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Machine({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    this.specifications,
    this.lastMaintenance,
    this.projectId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      specifications: json['specifications'] as Map<String, dynamic>?,
      lastMaintenance: json['last_maintenance'] != null
          ? DateTime.parse(json['last_maintenance'] as String)
          : null,
      projectId: json['project_id'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'status': status,
      'specifications': specifications,
      'last_maintenance': lastMaintenance?.toIso8601String(),
      'project_id': projectId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  bool get isOnline => status.toLowerCase() == 'online';
  bool get isOffline => status.toLowerCase() == 'offline';
  bool get isRunning => status.toLowerCase() == 'running';
  bool get isPaused => status.toLowerCase() == 'paused';
  
  String get statusIcon {
    switch (status.toLowerCase()) {
      case 'online':
      case 'running':
        return '🟢';
      case 'paused':
        return '⏸️';
      case 'offline':
        return '🔴';
      default:
        return '⚪';
    }
  }
}

class MachineCommand {
  final int id;
  final int machineId;
  final String command;
  final Map<String, dynamic>? parameters;
  final String status;
  final int userId;
  final DateTime createdAt;

  MachineCommand({
    required this.id,
    required this.machineId,
    required this.command,
    this.parameters,
    required this.status,
    required this.userId,
    required this.createdAt,
  });

  factory MachineCommand.fromJson(Map<String, dynamic> json) {
    return MachineCommand(
      id: json['id'] as int,
      machineId: json['machine_id'] as int,
      command: json['command'] as String,
      parameters: json['parameters'] as Map<String, dynamic>?,
      status: json['status'] as String,
      userId: json['user_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'machine_id': machineId,
      'command': command,
      'parameters': parameters,
    };
  }
}
