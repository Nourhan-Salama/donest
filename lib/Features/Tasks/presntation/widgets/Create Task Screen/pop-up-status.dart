import 'package:flutter/material.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Constants/app-styels.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

enum StatusType { success, error }

class StatusDialog extends StatelessWidget {
  final StatusType type;
  final String message;

  const StatusDialog({
    super.key,
    required this.type,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isSuccess = type == StatusType.success;

    return SizedBox(
      width: context.space(AppSpacing.xl) * 2,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppStyles.borderRadius,
        ),
        child: Padding(
          padding: EdgeInsets.all(context.space( AppSpacing.md)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? Colors.green : Colors.red,
               size: context.iconSize * 3,
              ),
              SizedBox(height: context.space( AppSpacing.md)),
              Text(
                message,
                textAlign: TextAlign.center,
                style:  TextStyle(
                  fontFamily: AppStyles.primaryFont,
                 fontSize: context.responsiveFont(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
