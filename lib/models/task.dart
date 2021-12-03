enum TaskStatus {
  incomplete,
  complete,
}

class Task {
  final String id;
  final String title;
  final String description;
  final TaskStatus status;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    this.status = TaskStatus.incomplete,
  });

  Task.fromJson(Map<String, dynamic> obj)
      : id = obj['id'],
        title = obj['title'],
        description = obj['description'],
        status = TaskStatus.values[obj['status']];

  bool get isComplete {
    return status == TaskStatus.complete;
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'status': status.index,
      };
}
