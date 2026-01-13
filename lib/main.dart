import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/Features/Tasks/data/models/task-model.dart';

import 'package:todo_app/Features/Tasks/presntation/screens/donest.dart';
import 'package:todo_app/core/Constants/hive-constants.dart';
import 'package:todo_app/core/Services/notification-service.dart';
import 'package:todo_app/core/Utils/app-logger.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   AppLogger.info('🚀 Starting app...');
  // Initialize Hive
  await Hive.initFlutter();
   // Register adapter
 Hive.registerAdapter(TaskModelAdapter());
  
  // Open box
 await Hive.openBox<TaskModel>(HiveConstants.tasksBox);
 // ✅ Initialize notifications
  final notificationService = NotificationService();
  await notificationService.initialize();
  await notificationService.requestPermissions();
  
  // ✅ Schedule daily notifications
  await notificationService.scheduleDailyEncouragement();
  await notificationService.scheduleEndOfDayCheck();
  
  AppLogger.success('✅ App initialized');

  runApp(const DoNest());
}


