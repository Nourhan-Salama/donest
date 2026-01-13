import 'package:flutter/material.dart';
import 'package:todo_app/core/Constants/app-styels.dart';
import 'package:todo_app/core/Extentions/responsive-extention.dart';
class Priority extends StatefulWidget {
  final Function(String)? onPrioritySelected;
  final String? selectedPriority; 

  Priority({super.key, this.onPrioritySelected, this.selectedPriority});

  @override
  State<Priority> createState() => _PriorityState();
}

class _PriorityState extends State<Priority> {
  String? selectedPriorityInternal;

  @override
  void initState() {
    super.initState();
    selectedPriorityInternal = widget.selectedPriority;
  }

  @override
  void didUpdateWidget(covariant Priority oldWidget) {
    super.didUpdateWidget(oldWidget);
  
    if (oldWidget.selectedPriority != widget.selectedPriority) {
      setState(() {
        selectedPriorityInternal = widget.selectedPriority;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Priority ',
          style: TextStyle(
            color: AppStyles.primaryColor,
            fontFamily: AppStyles.primaryFont,
            fontWeight: FontWeight.w600,
            fontSize: context.responsiveFont(16)
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _priorityOption('Low'),
            _priorityOption('Medium'),
            _priorityOption('High'),
          ],
        ),
      ],
    );
  }

  Widget _priorityOption(String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: selectedPriorityInternal,
          activeColor: AppStyles.primaryColor,
          onChanged: (String? val) {
            setState(() {
              selectedPriorityInternal = val;
            });
            widget.onPrioritySelected?.call(val!);
          },
        ),
        Text(
          value,
          style: TextStyle(
            color: AppStyles.primaryColor,
            fontFamily: AppStyles.primaryFont,
            fontWeight: FontWeight.w500,
            fontSize: context.responsiveFont(14),
          ),
        ),
      ],
    );
  }
}

