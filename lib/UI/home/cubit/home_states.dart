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
