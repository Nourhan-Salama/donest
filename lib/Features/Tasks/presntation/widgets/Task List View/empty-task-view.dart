import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/Constants/app-styels.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class EmptyTaskView extends StatelessWidget {
  const EmptyTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/todo-list.svg',
            width: context.screenWidth * 0.6,
            height: context.isPortrait
                ? context.screenHeight * 0.27
                : context.screenHeight * 0.5,
          ),
          Text(
            'Empty list..fill it with achievements',
            style: TextStyle(
              fontSize: context.responsiveFont(16),
              color: AppStyles.primaryColor,
              fontFamily: AppStyles.primaryFont,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
