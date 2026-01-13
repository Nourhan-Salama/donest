import 'package:flutter/material.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class DateHeader extends StatelessWidget {
  final String title;

  const DateHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.space(AppSpacing.sm),
        horizontal: context.space(AppSpacing.md),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: context.isPortrait
              ? context.responsiveFont( 14)
              : context.responsiveFont(16),
          fontWeight: FontWeight.w500,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}
