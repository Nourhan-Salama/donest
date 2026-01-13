import 'package:hive/hive.dart';
import 'package:todo_app/Features/Tasks/data/models/task-model.dart';


abstract class TaskLocalDataSource {
  Future<void> addTask(TaskModel task);
  Future<List<TaskModel>> getAllTasks();
  Future<void> deleteTask(String id);
  Future<void> updateTask(TaskModel task);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final Box<TaskModel> taskBox;

  TaskLocalDataSourceImpl(this.taskBox);

  @override
  Future<void> addTask(TaskModel task) async {
    await taskBox.put(task.id, task); // Key is task ID
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    return taskBox.values.toList();
  }

  @override
  Future<void> deleteTask(String id) async {
    await taskBox.delete(id);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    await taskBox.put(task.id, task);
  }
}