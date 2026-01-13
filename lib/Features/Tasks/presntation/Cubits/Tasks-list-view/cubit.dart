
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/Features/Tasks/data/models/task-model.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/Tasks-list-view/state.dart';
import 'package:todo_app/core/Services/notification-service.dart';
import 'package:todo_app/core/Utils/app-logger.dart';


class TaskCubit extends Cubit<TaskState> {
  final Box<TaskModel> taskBox;
   final NotificationService _notificationService = NotificationService();


  TaskCubit(this.taskBox) : super(TaskState(tasks: taskBox.values.toList())) {
    taskBox.listenable().addListener(_updateTasks);
    _scheduleNotifications();
    AppLogger.success('TaskCubit initialized with ${state.tasks.length} tasks'); // ✅
    
  }
    /// ✅ Schedule daily notifications
  void _scheduleNotifications() {
    _notificationService.scheduleDailyEncouragement();
    _notificationService.scheduleEndOfDayCheck();
    AppLogger.success('✅ Daily notifications scheduled');
  }

  void _updateTasks() {
    final allTasks = taskBox.values.toList();  // Get all tasks from Hive
    AppLogger.debug('_updateTasks called - Total tasks: ${allTasks.length}'); // ✅
    
    if (state.searchQuery.isNotEmpty) {
      final filtered = _filterTasks(allTasks, state.searchQuery);
      AppLogger.info('Filtering with query: "${state.searchQuery}" - Found: ${filtered.length}'); // ✅
      emit(state.copyWith(tasks: allTasks, filteredTasks: filtered));
    } else {
      AppLogger.debug('No search query - showing all tasks'); // ✅
      emit(TaskState(tasks: allTasks));
    }
  }

 
// toggle task completion
void toggleTaskCompletion(TaskModel task) {
  task.isCompleted = !task.isCompleted; //mutate the task
  task.save();
  AppLogger.success('Task toggled: ${task.taskName} - Completed: ${task.isCompleted}');
  
  final allTasks = taskBox.values.toList();
  
  // ✅ Create a BRAND NEW state (not copyWith)
  if (state.searchQuery.isNotEmpty) {
    final filtered = _filterTasks(allTasks, state.searchQuery);
    emit(TaskState(
      tasks: allTasks,
      searchQuery: state.searchQuery,
      filteredTasks: filtered,
    ));
  } else {
    // ✅ Create completely new state
    emit(TaskState(tasks: allTasks));
  }
  
  AppLogger.debug('✅ State updated - filteredTasks: ${state.filteredTasks.length}');
  // ✅ Check if all tasks completed
    _checkAllTasksCompleted();
}

/// ✅ Check if all tasks are completed
  void _checkAllTasksCompleted() {
    final todayTasks = _getTodayTasks();
    
    if (todayTasks.isEmpty) return;
    
    final completedTasks = todayTasks.where((t) => t.isCompleted).length;
    final totalTasks = todayTasks.length;

    AppLogger.info('📊 Today: $completedTasks/$totalTasks tasks completed');

    // ✅ If all tasks completed, celebrate!
    if (completedTasks == totalTasks && totalTasks > 0) {
      _notificationService.showCelebrationNotification();
      AppLogger.success('🎉 All tasks completed! Sending celebration!');
    }
  }


  /// ✅ Check incomplete tasks (call this at end of day)
  Future<void> checkIncompleteTasks() async {
    final todayTasks = _getTodayTasks();
    final incompleteTasks = todayTasks.where((t) => !t.isCompleted).toList();

    if (incompleteTasks.isNotEmpty) {
      await _notificationService.showIncompleteTaskNotification(
        taskCount: incompleteTasks.length,
      );
      AppLogger.info('📢 Sent incomplete task notification: ${incompleteTasks.length} tasks');
    }
  }

  /// Get today's tasks
  List<TaskModel> _getTodayTasks() {
    final now = DateTime.now();
    return state.tasks.where((task) {
      return task.createdAt.year == now.year &&
          task.createdAt.month == now.month &&
          task.createdAt.day == now.day;
    }).toList();
  }

  void searchTasks(String query) {
    AppLogger.info('🔎 searchTasks called with query: "$query"'); // ✅
    final allTasks = state.tasks;
    AppLogger.debug('Current tasks count: ${allTasks.length}'); // ✅
    
    if (query.isEmpty) {
      AppLogger.debug('Query is empty - showing all tasks'); // ✅
      emit(state.copyWith(
        searchQuery: '',
        filteredTasks: allTasks,
      ));
    } else {
      final filtered = _filterTasks(allTasks, query);
      AppLogger.success('Filtered results: ${filtered.length} tasks'); // ✅
      AppLogger.debug('Filtered task names: ${filtered.map((t) => t.taskName).toList()}'); // ✅
      emit(state.copyWith(
        searchQuery: query,
        filteredTasks: filtered,
      ));
    }
    AppLogger.info('New state - searchQuery: "${state.searchQuery}", filteredTasks: ${state.filteredTasks.length}'); // ✅
  }

  void clearSearch() {
    AppLogger.info('🗑️ clearSearch called'); // ✅
    emit(state.copyWith(
      searchQuery: '',
      filteredTasks: state.tasks,
    ));
    AppLogger.success('Search cleared - showing ${state.filteredTasks.length} tasks'); // ✅
  }

  List<TaskModel> _filterTasks(List<TaskModel> tasks, String query) {
    AppLogger.debug('_filterTasks called - Query: "$query", Total tasks: ${tasks.length}'); // ✅
    final lowerQuery = query.toLowerCase();
    final filtered = tasks.where((task) {
      final taskNameLower = task.taskName.toLowerCase();
      final taskTypeLower = task.taskType.toLowerCase();
      final matches = taskNameLower.contains(lowerQuery) || taskTypeLower.contains(lowerQuery);
      
      if (matches) {
        AppLogger.debug('   ✅ Match: "${task.taskName}" (Type: ${task.taskType})'); // ✅
      }
      
      return matches;
    }).toList();
    AppLogger.success('_filterTasks result: ${filtered.length} tasks matched'); // ✅
    return filtered;
  }

  
  void deleteTask(TaskModel task) {
  final taskName = task.taskName;
  task.delete();
  AppLogger.success('Task deleted: $taskName');
  
  final allTasks = taskBox.values.toList();
  
  // ✅ Create new state instead of copyWith
  if (state.searchQuery.isNotEmpty) {
    final filtered = _filterTasks(allTasks, state.searchQuery);
    emit(TaskState(
      tasks: allTasks,
      searchQuery: state.searchQuery,
      filteredTasks: filtered,
    ));
  } else {
    emit(TaskState(tasks: allTasks));
  }
}

  // calc  progress
double calculateDailyProgress(List<TaskModel> tasks) {
  AppLogger.debug('📊 Calculating progress for ${tasks.length} tasks'); // ✅
  
  // Don't filter by date! Just use the tasks passed in
  if (tasks.isEmpty) {
    AppLogger.debug('⚠️ No tasks to calculate progress');
    return 0;
  }

  final completedTasks = tasks.where((task) => task.isCompleted).length;
  final progress = completedTasks / tasks.length;
  
  AppLogger.success('✅ Progress: $completedTasks/$tasks.length = ${(progress * 100).toStringAsFixed(0)}%'); // ✅
  
  return progress;
}


  @override
  Future<void> close() {
    taskBox.listenable().removeListener(_updateTasks);
    AppLogger.info('TaskCubit closed'); // ✅
    return super.close();
  }
}