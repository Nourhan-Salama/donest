import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/Features/Tasks/data/models/task-model.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/Tasks-list-view/cubit.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Task%20List%20View/add-task-button.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Task%20List%20View/search-field.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Task%20List%20View/task-list-body.dart';
import 'package:todo_app/core/Constants/hive-constants.dart';


 class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final taskBox = Hive.box<TaskModel>(HiveConstants.tasksBox);

    return BlocProvider(
      create: (_) => TaskCubit(taskBox),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              SearchField(),
              Expanded(child: TaskListBody()),
            ],
          ),
        ),
        floatingActionButton: AddTaskButton(),
      ),
    );
  }
}
