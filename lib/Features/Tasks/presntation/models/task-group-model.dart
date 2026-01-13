import 'package:todo_app/Features/Tasks/data/models/task-model.dart';

// to calc the date groups
class TaskGroup {
  final String title; // Today, Yesterday, 12/1/2026
  final List<TaskModel> tasks;

  TaskGroup({
    required this.title,
    required this.tasks,
  });
}
