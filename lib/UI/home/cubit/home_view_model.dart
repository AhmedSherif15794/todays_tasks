import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todays_tasks/UI/home/cubit/home_states.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';
import 'package:todays_tasks/data/tasks/repository/tasks_repo.dart';
import 'package:todays_tasks/models/task_model.dart';

class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel({required this.tasksRepo})
    : super(HomeInitialState(date: DateTime.now()));
  String name = SharedPrefs.getPrefs().getData(key: 'name');
  DateTime selectedDate = DateTime.now();
  TasksRepo tasksRepo;
  List<TaskModel> tasks = [];
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  void goToPreviousDay() {
    updateSelectedDate(selectedDate.subtract(Duration(days: 1)));
  }

  void goToNextDay() {
    updateSelectedDate(selectedDate.add(Duration(days: 1)));
  }

  void returnToToday() {
    updateSelectedDate(DateTime.now());
  }

  void showDatePicker() {
    emit(HomeShowDatePickerState());
  }

  void updateSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    emit(HomeDateChangeState(date: selectedDate));
    getTasks(selectedDate);
  }

  void showThemeBottomSheet() {
    emit(HomeShowThemeBottomSheetState());
  }

  void showLanguageBottomSheet() {
    emit(HomeShowLanguageBottomSheetState());
  }

  void getTasks(DateTime date) async {
    try {
      emit(TasksLoadingState());
      // tasks = await tasksRepo.getTasks(date);
      var box = await Hive.openBox('tasks');
      tasks = (box.get(date.day.toString())?.cast<TaskModel>()) ?? [];
      tasks.isEmpty
          ? emit(NoTasksState())
          : emit(TasksSuccessState(tasks: tasks));
    } catch (e) {
      log(e.toString());
      emit(TasksErrorState(errorMessage: e.toString()));
    }
  }

  void saveTask() async {
    emit(TasksLoadingState());
    if (formKey.currentState!.validate()) {
      TaskModel task = TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        date: selectedDate,
      );
      // tasksRepo.saveTask(task);
      try {
        var box = await Hive.openBox("tasks");
        List<TaskModel> currentTasks =
            (box.get(task.date.day.toString())?.cast<TaskModel>()) ?? [];
        currentTasks.add(task);
        await box.put(task.date.day.toString(), currentTasks);
        emit(TaskSuccessSavedState());

        log("create Task view model${tasksRepo.getTasks(task.date)}");
        getTasks(task.date);
        // emit(TasksSuccessState(tasks: tasks));
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    }
  }

  void checkboxPressedTask(TaskModel task) async {
    var box = await Hive.openBox('tasks');
    // the whole list of the day
    List<TaskModel> currentTasks =
        box.get(task.date.day.toString()).cast<TaskModel>() ?? [];
    // the task we need to edit
    TaskModel myTask = currentTasks.firstWhere((element) {
      return element.id == task.id;
    });
    // the index of the task
    int index = currentTasks.indexOf(myTask);
    // remove the task from the list
    currentTasks.removeWhere((element) => element.id == task.id);
    // edit the task
    myTask.isCompleted = !myTask.isCompleted;
    // add the task to the list at the same index
    currentTasks.insert(index, myTask);
    // add the currentTasks list to the box
    box.put(task.date.day.toString(), currentTasks);
    // task.isCompleted = !task.isCompleted;
    log(myTask.isCompleted.toString());
    emit(TasksSuccessState(tasks: tasks));
  }
}
