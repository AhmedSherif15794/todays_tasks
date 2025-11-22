import 'package:todays_tasks/models/task_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {
  DateTime date;
  HomeInitialState({required this.date});
}

class HomeDateChangeState extends HomeStates {
  DateTime date;
  HomeDateChangeState({required this.date});
}

class HomeShowDatePickerState extends HomeStates {}

class HomeShowThemeBottomSheetState extends HomeStates {}

class HomeShowLanguageBottomSheetState extends HomeStates {}

class TasksStates extends HomeStates {}

class NoTasksState extends TasksStates {}

class TasksSuccessState extends TasksStates {
  List<TaskModel> tasks;
  TasksSuccessState({required this.tasks});
}

class TaskSuccessSavedState extends TasksStates {}

class TasksErrorState extends TasksStates {
  String errorMessage;
  TasksErrorState({required this.errorMessage});
}

class TasksLoadingState extends TasksStates {}
