import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todays_tasks/UI/home/cubit/home_states.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';

class HomeViewModel extends Cubit<HomeStates> {
  HomeViewModel() : super(HomeInitialState(date: DateTime.now()));
  String name = SharedPrefs.getPrefs().getData(key: 'name');
  DateTime selectedDate = DateTime.now();

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
  }
}
