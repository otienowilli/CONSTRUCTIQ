class ChatMessage {
  final int? id;
  final String message;
  final String sender;
  final bool isUser;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  ChatMessage({
    this.id,
    required this.message,
    required this.sender,
    required this.isUser,
    DateTime? timestamp,
    this.metadata,
  }) : timestamp = timestamp ?? DateTime.now();

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as int?,
      message: json['message'] as String,
      sender: json['sender'] as String,
      isUser: json['is_user'] as bool? ?? json['sender'] == 'user',
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'message': message,
      'sender': sender,
      'is_user': isUser,
      'timestamp': timestamp.toIso8601String(),
      if (metadata != null) 'metadata': metadata,
    };
  }

  factory ChatMessage.user(String message) {
    return ChatMessage(
      message: message,
      sender: 'user',
      isUser: true,
    );
  }

  factory ChatMessage.assistant(String message) {
    return ChatMessage(
      message: message,
      sender: 'assistant',
      isUser: false,
    );
  }
}
