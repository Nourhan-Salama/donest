import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/create-task/create-task-cubit.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/create-task/create-task-state.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Create%20Task%20Screen/save-button.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class BuildSaveButton extends StatelessWidget {
  const BuildSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.space(AppSpacing.lg)),
      // bottom: context.space(AppSpacing.md),
      // right: context.space(AppSpacing.md),
      child: BlocBuilder<CreateTaskCubit, CreateTaskState>(
        builder: (context, state) {
          if (state is CreateTaskLoading) {
            return const CircularProgressIndicator();
          }
          return SaveButton(
            onPressed: () => context.read<CreateTaskCubit>().saveTask(),
          );
        },
      ),
    );
  }
}
