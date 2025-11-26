import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todays_tasks/UI/home/cubit/home_view_model.dart';
import 'package:todays_tasks/models/task_model.dart';
import 'package:todays_tasks/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        horizontalTitleGap: 0,
        title: Text(
          widget.task.title,
          style: Theme.of(context).textTheme.bodySmall,
        ),

        subtitle: Text(
          widget.task.description != '' && widget.task.description != null
              ? ": ${widget.task.description}"
              : '',
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(fontSize: 12.sp),
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

        trailing: PopupMenuButton(
          position: PopupMenuPosition.over,
          elevation: 22,

          // menuPadding: EdgeInsets.all(22.r),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),

            side: BorderSide(
              color: Theme.of(context).primaryColorDark.withAlpha(20),
            ),
          ),
          color: Theme.of(context).cardColor,
          iconColor: Theme.of(context).primaryColorDark,
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () => homeViewModel.onEditTap(task: widget.task),
                child: ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.edit,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  leading: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColorDark,
                    size: 18.r,
                  ),
                ),
              ),

              PopupMenuItem(
                onTap: () => homeViewModel.deleteTask(widget.task),

                child: ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.delete,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  leading: Icon(
                    Icons.delete,
                    color: Theme.of(context).primaryColorDark,
                    size: 18.r,
                  ),
                ),
              ),
            ];
          },
        ),
      ),
    );
  }
}
