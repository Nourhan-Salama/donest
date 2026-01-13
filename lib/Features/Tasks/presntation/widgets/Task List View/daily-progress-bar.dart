import 'package:flutter/material.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Constants/app-styels.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class DailyProgressBar extends StatelessWidget {
  final double progress; 
  final double height;
  final int completedTasks;
  final int totalTasks;
  

 DailyProgressBar({
    super.key,
    required this.progress,
    this.height = 8,
    required this.completedTasks,
    required this.totalTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: context.screenWidth,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey[300], 
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft, // move from left to right
            widthFactor: progress, // 0.0 to 1.0 take percentage of parent width 
            child: Container(
              decoration: BoxDecoration(
                color: AppStyles.primaryColor, 
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
          ),
        ),
        SizedBox(height: context.space(AppSpacing.sm)),

        Text(
          '$completedTasks/$totalTasks ',
          style: TextStyle(
            fontFamily: AppStyles.primaryFont,
            fontSize: context.responsiveFont(14),
            fontWeight: FontWeight.w500,
            color: AppStyles.primaryColor,
          ),
        )
      ],
    );
  }
}
