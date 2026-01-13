import 'package:flutter/material.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Constants/app-styels.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class TaskFlied extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  TaskFlied({
    super.key,
    required this.label,
    this.hintText,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppStyles.primaryColor,
            fontFamily: AppStyles.primaryFont,
            fontWeight: FontWeight.w600,
            fontSize: context.responsiveFont(16),
          ),
        ),
        SizedBox(height:context.space(AppSpacing.xs)),
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyles.primaryColor),
            ),
            border: OutlineInputBorder(
              borderRadius: AppStyles.borderRadius,
              borderSide: BorderSide(color: AppStyles.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
