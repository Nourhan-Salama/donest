import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Constants/app-styels.dart';

import 'package:todo_app/core/Extentions/responsive-extention.dart';

class HomeOne extends StatelessWidget {
  const HomeOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // background image
      width: context.screenWidth,
      height: context.screenHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // DONest Text
                Padding(
                  padding: EdgeInsets.only(top: context.space(AppSpacing.xxl * 1.5)),

                  child: Text(
                    'DoNest',
                    style: TextStyle(
                      color: AppStyles.primaryColor,
                      fontFamily: AppStyles.primaryFont,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                       fontSize: context.responsiveFont(36),
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                ///Get Started Button
                SizedBox(
                  width: context.screenWidth * 0.7,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: context.space(
                        AppSpacing.xxl,
                      ), // scalable bottom padding
                      left: context.space(AppSpacing.md),
                      right: context.space(AppSpacing.md),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/home2');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                         vertical: context.space(AppSpacing.md),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppStyles.borderRadius,
                        ),
                      ),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: context.responsiveFont(24),
                          color: AppStyles.primaryColor,
                          fontFamily: AppStyles.primaryFont,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
