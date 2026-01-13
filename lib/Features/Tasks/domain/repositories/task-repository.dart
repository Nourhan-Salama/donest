import 'package:todo_app/Features/Tasks/domain/entities/task-entity.dart';

abstract class TaskRepository {
  Future<void> addTask(TaskEntity task);
  Future<List<TaskEntity>> getAllTasks();
  Future<void> deleteTask(String id);
  Future<void> updateTask(TaskEntity task);
}