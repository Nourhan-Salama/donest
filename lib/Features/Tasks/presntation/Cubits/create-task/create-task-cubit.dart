
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/Features/Tasks/data/models/task-model.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/create-task/create-task-state.dart';
import 'package:todo_app/core/Constants/hive-constants.dart';
import 'package:todo_app/core/Utils/app-logger.dart';
import 'package:uuid/uuid.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(const CreateTaskInitial());

  static const _uuid = Uuid();

  String _taskType = '';
  String _taskName = '';
  String? _priority;

  // Getters
  String get taskType => _taskType;
  String get taskName => _taskName;
  String? get priority => _priority;

  // Update methods
  void updateTaskType(String value) {
    _taskType = value;
  }

  void updateTaskName(String value) {
    _taskName = value;
  }

  void updatePriority(String? value) {
    _priority = value;
    emit(CreateTaskPriorityChanged(value));
  }

  // Validation
  bool validateInputs() {
    if (_priority == null) {
      AppLogger.error('Validation failed: Priority not selected');
      emit(const CreateTaskValidationError('Please select a priority'));
      return false;
    }

    if (_taskType.trim().isEmpty || _taskName.trim().isEmpty) {
      AppLogger.error('Validation failed: Empty fields');
      emit(const CreateTaskValidationError('Please fill all fields'));
      return false;
    }

    return true;
  }

  // Save task
  Future<void> saveTask() async {
    if (!validateInputs()) return;

    emit(const CreateTaskLoading());

    try {
      await _saveTaskToDatabase();
      _clearForm();
      emit(const CreateTaskSuccess('Task saved successfully!'));
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  Future<void> _saveTaskToDatabase() async {
    AppLogger.info('Starting to save task...');

    final box = Hive.box<TaskModel>(HiveConstants.tasksBox);
    final task = _createTask();

    await box.add(task);

    _logSuccess(task, box.length);
  }

  TaskModel _createTask() {
    return TaskModel(
      id: _uuid.v4(),
      taskType: _taskType.trim(),
      taskName: _taskName.trim(),
      priority: _priority!,
      createdAt: DateTime.now(),
    );
  }

  void _logSuccess(TaskModel task, int totalTasks) {
    AppLogger.success('Task saved! Total tasks: $totalTasks');
    AppLogger.debug(
      'Task: ${task.taskName} | Type: ${task.taskType} | Priority: ${task.priority}',
    );
  }

  void _handleError(Object error, StackTrace stackTrace) {
    AppLogger.error('Failed to save task', error);
    emit(CreateTaskError('Failed to save task: ${error.toString()}'));
  }

  void _clearForm() {
    _taskType = '';
    _taskName = '';
    _priority = null;
  }

  void resetForm() {
    _clearForm();
    emit(const CreateTaskInitial());
  }
}
