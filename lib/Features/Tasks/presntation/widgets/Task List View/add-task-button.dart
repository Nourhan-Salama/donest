import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/Constants/app-styels.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.push('/task-screen'),
      backgroundColor: AppStyles.primaryColor,
      child: Icon(Icons.add, color: AppStyles.secondColor),
    );
  }
}
