import 'package:flutter/material.dart';
import 'package:todo_app/core/App%20Router/app-router.dart';


class DoNest extends StatelessWidget {
  const DoNest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
