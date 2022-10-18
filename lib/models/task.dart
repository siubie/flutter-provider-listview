import 'dart:convert';

class Task {
  String name;
  int status;

  Task({
    required this.name,
    required this.status,
  });

  Task copyWith({
    String? name,
    int? status,
  }) {
    return Task(
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'status': status});

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      name: map['name'] ?? '',
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() => 'Task(name: $name, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task && other.name == name && other.status == status;
  }

  @override
  int get hashCode => name.hashCode ^ status.hashCode;
}
