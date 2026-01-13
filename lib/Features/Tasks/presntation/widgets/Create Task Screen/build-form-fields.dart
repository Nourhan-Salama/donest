                      
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/create-task/create-task-cubit.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/create-task/create-task-state.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Create%20Task%20Screen/priority.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Create%20Task%20Screen/task-fied.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class BuildFormFields extends StatelessWidget {
  // ✅ Accept controllers from parent (now StatelessWidget!)
  final TextEditingController taskTypeController;
  final TextEditingController taskNameController;

  const BuildFormFields({
    super.key,
    required this.taskTypeController,
    required this.taskNameController,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateTaskCubit>();

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.space(AppSpacing.md)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TaskFlied(
            label: 'Task Type',
            controller: taskTypeController, // ✅ Use passed controller
            onChanged: cubit.updateTaskType,
          ),
          SizedBox(height: context.space(AppSpacing.md)),

          TaskFlied(
            label: 'Your Task',
            controller: taskNameController, // ✅ Use passed controller
            onChanged: cubit.updateTaskName,
          ),

          SizedBox(height: context.space(AppSpacing.lg)),

          BlocBuilder<CreateTaskCubit, CreateTaskState>(
            buildWhen: (previous, current) =>
                current is CreateTaskPriorityChanged ||
                current is CreateTaskInitial,
            builder: (context, state) {
              return Priority(
                key: ValueKey(cubit.priority),
                selectedPriority: cubit.priority,
                onPrioritySelected: cubit.updatePriority,
              );
            },
          ),
        ],
      ),
    );
  }
}