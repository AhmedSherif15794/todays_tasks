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
      tasks = await tasksRepo.getTasks(date);
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
      // the valid task
      TaskModel task = TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        date: selectedDate,
        id: IdGenerator.getNextId(),
      );
      try {
        // save the task
        tasksRepo.saveTask(task);
        emit(TaskSuccessSavedState());
        getTasks(task.date);
      } catch (e) {
        emit(TasksErrorState(errorMessage: e.toString()));
      }
    }
  }

  void checkboxPressedTask(TaskModel task) async {
    tasksRepo.editTasks(
      task: task,
      title: task.title,
      description: task.description ?? '',
      isCompleted: !task.isCompleted,
    );
    log("is completed  ? ${task.isCompleted}");
    getTasks(task.date);
  }
}
