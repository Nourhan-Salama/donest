

import 'package:todo_app/Features/Tasks/data/models/task-model.dart';

class TaskState  {
  final List<TaskModel> tasks;        // All tasks
  final String searchQuery;            // ✅ What user typed
  final List<TaskModel> filteredTasks; // ✅ Tasks matching search
 

  const TaskState({
    required this.tasks,
    this.searchQuery = '',             // Default: empty
    List<TaskModel>? filteredTasks,    // Default: null
  }) : filteredTasks = filteredTasks ?? tasks; // If null, show all tasks
  

  // CopyWith for immutability
  TaskState copyWith({
    List<TaskModel>? tasks,
    String? searchQuery,
    List<TaskModel>? filteredTasks,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      searchQuery: searchQuery ?? this.searchQuery,
      filteredTasks: filteredTasks ?? this.filteredTasks,
 
    );
  }

 
}