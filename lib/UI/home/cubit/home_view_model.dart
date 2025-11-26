import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todays_tasks/UI/home/cubit/home_states.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';
import 'package:todays_tasks/data/tasks/repository/tasks_repo.dart';
import 'package:todays_tasks/models/task_model.dart';

class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel({required this.tasksRepo})
    : super(
        HomeInitialState(
          date: DateTime.now(),
          name: SharedPrefs.getPrefs().getData(key: 'name'),
        ),
      );

  DateTime selectedDate = DateTime.now();
  TasksRepo tasksRepo;
  List<TaskModel> tasks = [];
  final GlobalKey<FormState> createTaskFormKey = GlobalKey();
  final GlobalKey<FormState> editTaskFormKey = GlobalKey();
  final GlobalKey<FormState> editNameFormKey = GlobalKey();
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController createTaskTitleController =
      TextEditingController();
  final TextEditingController createTaskDescriptionController =
      TextEditingController();
  final TextEditingController editTaskTitleController = TextEditingController();
  final TextEditingController editTaskDescriptionController =
      TextEditingController();

  void editName(String name) {
    if (editNameFormKey.currentState!.validate()) {
      SharedPrefs.getPrefs().setData(key: 'name', value: name);
      editNameController.clear();

      emit(HomeInitialState(date: DateTime.now(), name: name));
    }
  }

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

  void showEditNameDialog() {
    emit(ShowEditNameDialogState());
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
    if (createTaskFormKey.currentState!.validate()) {
      // the valid task
      TaskModel task = TaskModel(
        title: createTaskTitleController.text,
        description: createTaskDescriptionController.text,
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

  void editTask(TaskModel task) {
    emit(TasksLoadingState());
    if (editTaskFormKey.currentState!.validate()) {
      try {
        // edit the task
        tasksRepo.editTask(
          task: task,
          title: editTaskTitleController.text,
          description: editTaskDescriptionController.text,
          isCompleted: task.isCompleted,
        );
        emit(TaskSuccessEditedState());
        getTasks(task.date);
      } catch (e) {
        emit(TasksErrorState(errorMessage: e.toString()));
      }
    }
  }

  void checkboxPressedTask(TaskModel task) async {
    tasksRepo.editTask(
      task: task,
      title: task.title,
      description: task.description ?? '',
      isCompleted: !task.isCompleted,
    );
    log("id is : ${task.id}");

    getTasks(task.date);
  }

  void onEditTap({required TaskModel task}) {
    editTaskTitleController.text = task.title;
    editTaskDescriptionController.text = task.description ?? '';
    emit(GoToEditView(task: task));
  }

  void onFABTap() {
    emit(GoTocreateView());
  }

  void deleteTask(TaskModel task) {
    tasksRepo.deleteTask(task);
    log(task.id.toString());
    getTasks(selectedDate);
  }
}
