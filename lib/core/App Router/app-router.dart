import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/Features/Tasks/data/models/task-model.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/Tasks-list-view/cubit.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/create-task/create-task-cubit.dart';
import 'package:todo_app/Features/Tasks/presntation/screens/home/home.dart';
import 'package:todo_app/Features/Tasks/presntation/screens/Tasks%20List%20View/task-list-view.dart';
import 'package:todo_app/Features/Tasks/presntation/screens/Create%20Task%20Screen/create-task-screen.dart';
import 'package:todo_app/core/Constants/hive-constants.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/home1',
    routes: [
      GoRoute(
        path: '/home1',
        name: 'home-one',
        builder: (context, state) => const Home(),
      ),
      // GoRoute(
      //   path: '/home2',
      //   name: 'home-two',
      //   builder: (context, state) => const TaskListView(),
      // ),
      GoRoute(
        path: '/home2',
        name: 'home-two',
        builder: (context, state) {
          var taskBox = Hive.box<TaskModel>(HiveConstants.tasksBox);

          return BlocProvider(
            create: (_) => TaskCubit(taskBox),
            child: const TaskListView(),
          );
        },
      ),
      GoRoute(
        path: '/task-screen',
        name: 'task-screen',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => CreateTaskCubit(),
            child: const TaskScreen(),
          );
        },
      ),
    ],
    // insted of scaffold here we can use error page screen ***
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Something went wrong. Please try again later 💫'),
      ),
    ),
  );
}
