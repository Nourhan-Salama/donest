import 'package:hive/hive.dart';
import 'package:todo_app/Features/Tasks/domain/entities/task-entity.dart';

part 'task-model.g.dart';


@HiveType(typeId: 0) // Unique ID for this model
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String taskType;

  @HiveField(2)
  final String taskName;

  @HiveField(3)
  final String priority;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
 bool isCompleted ;

  TaskModel({
    required this.id,
    required this.taskType,
    required this.taskName,
    required this.priority,
    required this.createdAt,
     this.isCompleted = false,
  });

  // Convert to Entity
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      taskType: taskType,
      taskName: taskName,
      priority: priority,
      createdAt: createdAt,
      isCompleted: isCompleted

    );
  }

  // Create from Entity
  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      taskType: entity.taskType,
      taskName: entity.taskName,
      priority: entity.priority,
      createdAt: entity.createdAt,
      isCompleted: entity.isCompleted,
    );
  }
}