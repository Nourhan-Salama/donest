import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/Features/Tasks/presntation/Cubits/Tasks-list-view/cubit.dart';
import 'package:todo_app/Features/Tasks/presntation/widgets/Task%20List%20View/priority-stars.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Constants/app-styels.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class TaskCard extends StatefulWidget {
  final dynamic task;
  TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
  
    String taskType = widget.task.taskType;   
    String taskName = widget.task.taskName;    
    String priority = widget.task.priority;  
    
    

    return Padding(
       padding: EdgeInsets.symmetric(horizontal:  context.space(AppSpacing.md)),
     
      child: Container(
        //width: context.screenWidth * 0.9,
        width: context.screenWidth,
        height: context.isPortrait
               ? context.space(AppSpacing.xl * 2.5) 
               : context.space(AppSpacing.xl * 3.5),
      
        decoration: BoxDecoration(
            borderRadius: AppStyles.borderRadius,
            color: AppStyles.secondColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              //checkbok and priority stars
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                  children: [
                    //checkbox
                    Checkbox(
                      value: widget.task.isCompleted,
                      activeColor: AppStyles.primaryColor,
                      onChanged: (_) {
                        
                         context.read<TaskCubit>().toggleTaskCompletion(widget.task);
                         setState(() {}); // forces rebuild of this card
                      },
                    ),

                    // Task type
                    Text(
                     taskType,
                    style: TextStyle(
                      color: AppStyles.primaryColor,
                      fontFamily: AppStyles.primaryFont,
                      fontWeight: FontWeight.w700,
                      fontSize: context.responsiveFont(16),
                    ),
                    ),
                  ],
                 ),

                  //  Priority stars
                 PriorityStars(priority: priority ),
      
               ],
             ),

              // Task name
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:  context.space( AppSpacing.md)),
                child: Text(
                  taskName,
                 
                  style: TextStyle(
                    fontFamily: AppStyles.primaryFont,
                    fontWeight: FontWeight.w500,
                    fontSize: context.responsiveFont(14),
                    color: AppStyles.primaryColor,
                  ),
                ),
              ),
            ],
          ),
      
      ),
    );
  }
}