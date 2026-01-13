import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Create%20Task%20Screen/build-form-fields.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Create%20Task%20Screen/build-save-button.dart';
import 'package:todo_app/core/Constants/app-styels.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class BuildTaskForm extends StatelessWidget {
   // ✅ Accept controllers from parent
  final TextEditingController taskTypeController;
  final TextEditingController taskNameController;
 BuildTaskForm({super.key,required this.taskNameController,required this.taskTypeController});

  @override
  Widget build(BuildContext context) {
   
    return Center(
      child: Container(
        width: context.screenWidth * 0.9,
        constraints: BoxConstraints(
        maxHeight: context.screenHeight * 0.9, // ✅ Max height instead
      ),
        decoration: BoxDecoration(
          borderRadius: AppStyles.borderRadius,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        // child: Stack(
        //   children: [
        //   BuildFormFields(
        //      // ✅ Pass controllers to BuildFormFields
        //     taskTypeController: taskTypeController,
        //         taskNameController: taskNameController,
        //   ),
        //    BuildSaveButton()
        //   ],
        // ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              // ✅ Pass controllers to BuildFormFields
              child: BuildFormFields(
                taskTypeController: taskTypeController,
                taskNameController: taskNameController,
              ),
            ),
            BuildSaveButton(),
          ],
        ),
       
      ),
    );

  }
}