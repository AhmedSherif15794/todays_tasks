import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todays_tasks/UI/home/cubit/home_states.dart';
import 'package:todays_tasks/UI/home/cubit/home_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todays_tasks/UI/home/widgets/home_drawer.dart';
import 'package:todays_tasks/UI/home/widgets/task_widget.dart';
import 'package:todays_tasks/utils/app_colors.dart';
import 'package:todays_tasks/utils/app_routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel viewModel;
  @override
  void initState() {
    viewModel = BlocProvider.of<HomeViewModel>(context, listen: false);
    viewModel.getTasks(viewModel.selectedDate);
    log("Again");
    super.initState();
  }

  void del() async {
    var box = await Hive.openBox('tasks');
    box.delete(viewModel.selectedDate.day.toString());
  }

  @override
  Widget build(BuildContext context) {
    // del();
    return Scaffold(
      drawer: HomeDrawer(),

      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: AppColors.transparent,
        surfaceTintColor: AppColors.transparent,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.todays_tasks,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),

      floatingActionButton: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          if (viewModel.selectedDate.day >= DateTime.now().day) {
            return FloatingActionButton(
              onPressed: () {
                // navigator to create task
                Navigator.pushNamed(context, AppRoutes.createTask);
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add,
                color: Theme.of(context).cardColor,
                size: 40.r,
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.r),
          child: Column(
            spacing: 16.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // welcome text
              BlocSelector<HomeViewModel, HomeStates, HomeInitialState>(
                selector: (state) {
                  return HomeInitialState(date: DateTime.now());
                },
                builder: (context, state) {
                  if (state.date.hour > 0 && state.date.hour < 12) {
                    return Text(
                      "${AppLocalizations.of(context)!.good_morning}, \n${viewModel.name}",
                      style: Theme.of(context).textTheme.headlineLarge,
                    );
                  } else if (state.date.hour >= 12 && state.date.hour < 17) {
                    return Text(
                      "${AppLocalizations.of(context)!.good_afternoon}, \n${viewModel.name}",
                      style: Theme.of(context).textTheme.headlineLarge,
                    );
                  } else {
                    return Text(
                      "${AppLocalizations.of(context)!.good_evening}, \n${viewModel.name}",
                      style: Theme.of(context).textTheme.headlineLarge,
                    );
                  }
                },
              ),

              // date
              BlocConsumer<HomeViewModel, HomeStates>(
                listener: (context, state) async {
                  if (state is HomeShowDatePickerState) {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: viewModel.selectedDate.subtract(
                        Duration(days: 365),
                      ),
                      lastDate: viewModel.selectedDate.add(Duration(days: 365)),
                      initialDate: viewModel.selectedDate,
                    );
                    if (pickedDate != null) {
                      viewModel.updateSelectedDate(pickedDate);
                    }
                  }
                },
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // back
                      IconButton(
                        onPressed: () {
                          // go to previous date
                          viewModel.goToPreviousDay();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),

                      // date
                      GestureDetector(
                        onLongPress: () {
                          // open date picker
                          viewModel.showDatePicker();
                        },
                        onDoubleTap: () {
                          // return to today
                          viewModel.returnToToday();
                        },
                        child: Text(
                          DateFormat.MMMEd().format(viewModel.selectedDate),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      // forward
                      IconButton(
                        onPressed: () {
                          // go to next date
                          viewModel.goToNextDay();
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ],
                  );
                },
              ),

              SizedBox(height: 22.h),

              // tasks
              BlocBuilder<HomeViewModel, HomeStates>(
                buildWhen: (previous, current) => current is TasksStates,
                builder: (context, state) {
                  // no tasks
                  if (state is NoTasksState) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          "No Tasks for this day.",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    );
                  }
                  // tasks
                  else if (state is TasksSuccessState) {
                    // viewModel.tasks.clear();

                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder:
                            (context, index) => SizedBox(height: 20.h),
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          return TaskWidget(task: state.tasks[index]);
                        },
                      ),
                    );
                  }
                  // error
                  else if (state is TasksErrorState) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          state.errorMessage,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    );
                  }
                  // loading
                  else {
                    return Center(child: CircularProgressIndicator());
                  }

                  // return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
