
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:todo_app/Features/Tasks/presntation/Cubits/Tasks-list-view/cubit.dart';
import 'package:todo_app/core/Constants/app-spacing.dart';
import 'package:todo_app/core/Constants/app-styels.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();

   @override
  void dispose() {
    _searchController.dispose(); // Clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Get the cubit
    final taskCubit = context.read<TaskCubit>();
    
    return Padding(
      padding: EdgeInsets.all(context.space(AppSpacing.md)),
      child: TextField(
        controller: _searchController, 
        // ✅ When user types, call searchTasks
        onChanged: (value) {
          taskCubit.searchTasks(value);
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppStyles.primaryColor),
          ),
          hintText: 'Search for tasks',
          hintStyle: TextStyle(
            color: AppStyles.primaryColor,
            fontFamily: AppStyles.primaryFont,
            fontWeight: FontWeight.w500,
            fontSize: context.responsiveFont(14),
          ),
          prefixIcon: Icon(Icons.search, color: AppStyles.primaryColor),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.close,
              color: const Color.fromARGB(242, 121, 85, 72),
            ),
            // ✅ When user clicks X, clear search
            onPressed: () {
              _searchController.clear(); 
              taskCubit.clearSearch();
            },
            focusColor: AppStyles.primaryColor,
            iconSize: context.iconSize,
          ),
          border: OutlineInputBorder(
            borderRadius: AppStyles.borderRadius,
            borderSide: BorderSide(color: AppStyles.primaryColor),
          ),
        ),
      ),
    );
  }
}
