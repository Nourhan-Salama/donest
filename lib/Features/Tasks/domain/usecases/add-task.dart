import 'package:todo_app/Features/Tasks/domain/entities/task-entity.dart';
import 'package:todo_app/Features/Tasks/domain/repositories/task-repository.dart';

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<void> call(TaskEntity task) async {
    return await repository.addTask(task);
  }
}