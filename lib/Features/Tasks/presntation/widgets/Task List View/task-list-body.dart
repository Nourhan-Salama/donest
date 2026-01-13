import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/Tasks-list-view/cubit.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/Tasks-list-view/state.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Task%20List%20View/daily-progress-bar.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Task%20List%20View/date-header.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Task%20List%20View/empty-task-view.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Task%20List%20View/task-card.dart';
import 'package:todo_app/Features/Tasks/presntation/Utils/task-grouping.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Constants/app-styels.dart';
import 'package:todo_app/core/Utils/app-logger.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class TaskListBody extends StatelessWidget {
  const TaskListBody({super.key});

  @override
  Widget build(BuildContext context) {
    AppLogger.debug('🎨 TaskListBody build called');
    // get task cubit only once
    final taskCubit = context.read<TaskCubit>();

    return BlocBuilder<TaskCubit, TaskState>(
     
      builder: (context, state) {
        AppLogger.info('🔄 BlocBuilder rebuilding');
        AppLogger.debug(
          'State - Total: ${state.tasks.length}, Query: "${state.searchQuery}", Filtered: ${state.filteredTasks.length}',
        );

        // ✅ USE filteredTasks instead of tasks!
        final tasksToShow = state.filteredTasks;
        AppLogger.debug('Tasks to show: ${tasksToShow.length}');

        // ✅ Handle empty states
        if (tasksToShow.isEmpty) {
          // If search query exists, show "no results" message
          if (state.searchQuery.isNotEmpty) {
            AppLogger.info('⚠️ No search results for: "${state.searchQuery}"');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: context.iconSize * 5,
                    color: Colors.grey,
                  ),
                  SizedBox(height: context.space(AppSpacing.md)),
                  Text(
                    'No tasks found for "${state.searchQuery}"',
                    style: TextStyle(
                      fontSize: context.responsiveFont(16),
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          // If no search query, show empty task view
          AppLogger.info('⚠️ No tasks at all');
          return const EmptyTaskView();
        }

        // ✅ Group the filtered tasks by date
        final groups = groupTasksByDate(tasksToShow.reversed.toList());
        
        AppLogger.success(
          'Grouped ${tasksToShow.length} tasks into ${groups.length} date groups',
        );

        return ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            final group = groups[index];

            AppLogger.info('========== GROUP: ${group.title} ==========');

            for (var task in group.tasks) {
              AppLogger.debug(
                'Task: ${task.taskName} - isCompleted: ${task.isCompleted}',
              );
            }
            


             final totalTasks = group.tasks.length;
            final completedTasks = group.tasks.where((task) => task.isCompleted).length;
            final progress = taskCubit.calculateDailyProgress(group.tasks);

            AppLogger.info(
              'Calculated progress: ${(progress * 100).toStringAsFixed(0)}%',
            );

            AppLogger.info('=========================================');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.space(AppSpacing.sm)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.space(AppSpacing.md),
                  ),
                  child: DailyProgressBar(
                    progress: progress,
                    completedTasks: completedTasks,  
                    totalTasks: totalTasks,  
                    height: context.space(AppSpacing.sm),
                  ),
                ),

                SizedBox(height: context.space(AppSpacing.sm)),
                DateHeader(title: group.title),
                ...group.tasks.map(
                  // spread operator :  taking list of items and putting them individul to anthor list or column or row as map returns itterable not list
                  (task) => Padding(
                    padding: EdgeInsets.only(
                      bottom: context.space(AppSpacing.md),
                    ),
                    child: Dismissible(
                      key: Key(task.key.toString()),
                      movementDuration: const Duration(milliseconds: 300),
                      resizeDuration: const Duration(milliseconds: 200),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        context.read<TaskCubit>().deleteTask(task);
                        AppLogger.success('Task dismissed: ${task.taskName}');
                      },
                      background: Container(
                        color: AppStyles.primaryColor,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          left: context.space(AppSpacing.md),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Deleting...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: context.responsiveFont(16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: context.iconSize * 1.5,
                            ),
                          ],
                        ),
                      ),

                      child: TaskCard(task: task),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
