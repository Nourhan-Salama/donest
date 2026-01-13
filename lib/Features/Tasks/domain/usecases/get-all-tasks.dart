import 'package:todo_app/Features/Tasks/domain/entities/task-entity.dart';
import 'package:todo_app/Features/Tasks/domain/repositories/task-repository.dart';

class GetAllTasks {
  final TaskRepository repository;

  GetAllTasks(this.repository);

  Future<List<TaskEntity>> call() async {
    return await repository.getAllTasks();
  }
}