class TaskEntity{
  final String id;
  final String taskType;
  final String taskName;
  final String priority;
  final DateTime createdAt;
  bool isCompleted;

  TaskEntity({
    required this.id,
    required this.taskType,
    required this.taskName,
    required this.priority,
    required this.createdAt,
    this.isCompleted = false,
  });
}