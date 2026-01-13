import 'package:intl/intl.dart';
import 'package:todo_app/Features/Tasks/data/models/task-model.dart';
import 'package:todo_app/Features/Tasks/presntation/models/task-group-model.dart';


List<TaskGroup> groupTasksByDate(List<TaskModel> tasks) {
  final Map<String, List<TaskModel>> map = {};

  for (final task in tasks) {
    final title = formatTaskDate(task.createdAt);
    map.putIfAbsent(title, () => []).add(task);
  }

  return map.entries
      .map((e) => TaskGroup(title: e.key, tasks: e.value))
      .toList();
}

String formatTaskDate(DateTime date) {
  final now = DateTime.now();

  if (_isSameDay(date, now)) return 'Today';
  if (_isSameDay(date, now.subtract(const Duration(days: 1)))) {
    return 'Yesterday';
  }

  return DateFormat('dd MMM yyyy').format(date);
}

bool _isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;
