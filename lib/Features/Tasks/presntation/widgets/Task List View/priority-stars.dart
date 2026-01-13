import 'package:flutter/material.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Constants/app-styels.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class PriorityStars extends StatelessWidget {
  final String priority; // "Low", "Medium", "High"

  const PriorityStars({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    int starCount = 0;

    switch (priority) {
      case 'Low':
        starCount = 1;
        break;
      case 'Medium':
        starCount = 2;
        break;
      case 'High':
        starCount = 3;
        break;
    }

    return Padding(
      padding:  EdgeInsets.all(context.space(AppSpacing.sm)),
      child: Row(
        children: List.generate(
          3, // always show 3 stars
          (index) => Icon(
            index < starCount ? Icons.star : Icons.star_border,
            color: AppStyles.primaryColor,
            size: context.iconSize ,
          ),
        ),
      ),
    );
  }
}
