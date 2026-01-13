import 'package:flutter/widgets.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Constants/app-styels.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: EdgeInsets.all(context.space(AppSpacing.md)),
      child: Text(
        'Make it happen 💪',
        style: TextStyle(
          color: AppStyles.secondColor,
          fontFamily: AppStyles.primaryFont,
          fontWeight: FontWeight.w700,
          fontSize: context.responsiveFont(24),
        ),
      ),
    );

  }
}