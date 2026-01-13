import 'package:todo_app/Features/Tasks/data/datasources/task-local-datasource.dart';
import 'package:todo_app/Features/Tasks/data/models/task-model.dart';
import 'package:todo_app/Features/Tasks/domain/entities/task-entity.dart';
import 'package:todo_app/Features/Tasks/domain/repositories/task-repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTask(TaskEntity task) async {
    final taskModel = TaskModel.fromEntity(task);
    await localDataSource.addTask(taskModel);
  }

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    final taskModels = await localDataSource.getAllTasks();
    return taskModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> deleteTask(String id) async {
    await localDataSource.deleteTask(id);
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final taskModel = TaskModel.fromEntity(task);
    await localDataSource.updateTask(taskModel);
  }
}