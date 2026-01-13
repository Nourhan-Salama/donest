import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/create-task/create-task-cubit.dart';
import 'package:todo_app/Features/Tasks/presntation/Cubits/create-task/create-task-state.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Create%20Task%20Screen/build-illustration.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Create%20Task%20Screen/build-task-form.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Create%20Task%20Screen/header.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Create%20Task%20Screen/pop-up-status.dart';
import 'package:todo_app/core/Constants/app-styels.dart';



class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _taskTypeController = TextEditingController();
  final _taskNameController = TextEditingController();

  @override
  void dispose() {
    _taskTypeController.dispose();
    _taskNameController.dispose();
    super.dispose();
  }

  void _showStatusDialog(StatusType type, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => StatusDialog(type: type, message: message),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTaskCubit, CreateTaskState>(
      listener: _handleStateChange,
      child: Scaffold(
        backgroundColor: AppStyles.primaryColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                 BuildHeader(),
                  BuildTaskForm(
                    taskTypeController: _taskTypeController,
                    taskNameController: _taskNameController,
                  ),
                  BuildIllustration()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleStateChange(BuildContext context, CreateTaskState state) {
    switch (state) {
      case CreateTaskSuccess():
        _showStatusDialog(StatusType.success, state.message);
        Future.delayed(const Duration(seconds: 2), () {

          _taskTypeController.clear();
          _taskNameController.clear();


        // Clear priority in Cubit and force UI rebuild
        context.read<CreateTaskCubit>().resetForm();
        });

      case CreateTaskValidationError():
        _showStatusDialog(StatusType.error, state.message);

      case CreateTaskError():
        _showStatusDialog(StatusType.error, state.message);

      default:
        break;
    }
  }  

 
}

