import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todays_tasks/UI/home/cubit/home_view_model.dart';
import 'package:todays_tasks/models/task_model.dart';
import 'package:todays_tasks/utils/app_colors.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key, required this.task});
  // final String taskTitle;
  final TaskModel task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    var homeViewModel = BlocProvider.of<HomeViewModel>(context);
    return Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: Theme.of(context).primaryColorDark),
      ),
      color: AppColors.transparent,
      shadowColor: AppColors.transparent,
      child: ListTile(
        // shape: BeveledRectangleBorder(
        //   borderRadius: BorderRadius.circular(8.r),
        //   side: BorderSide(color: Theme.of(context).primaryColorDark),
        // ),
        title: Text(
          widget.task.title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        leading: Checkbox(
          side: BorderSide(color: Theme.of(context).primaryColorDark),
          value: widget.task.isCompleted,
          onChanged: (value) {
            homeViewModel.checkboxPressedTask(widget.task);
            // widget.task.isCompleted = value!;

            // isCompleted = value!;
            // setState(() {});
          },
        ),
      ),
    );
  }
}
