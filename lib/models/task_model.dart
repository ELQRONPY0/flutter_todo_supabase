class Task {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final bool isDone;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.isDone,
    required this.createdAt,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      isDone: map['is_done'] ?? false,
      createdAt: DateTime.tryParse(map['created_at']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'title': title,
      'description': description,
      'is_done': isDone,
    };
  }

  Task copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
