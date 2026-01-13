import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Constants/app-styels.dart';

import 'package:todo_app/core/Extentions/responsive-extention.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all( context.space(AppSpacing.md),),
        backgroundColor: AppStyles.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: AppStyles.borderRadius),
        
      ),
      child: Text(
        'Save',
        style: TextStyle(
          color: AppStyles.secondColor,
          fontSize: context.responsiveFont(18),
          fontFamily: AppStyles.primaryFont,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
