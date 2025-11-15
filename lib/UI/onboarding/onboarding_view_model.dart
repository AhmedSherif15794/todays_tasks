import 'package:flutter/material.dart';
import 'package:todays_tasks/UI/onboarding/onboarding_navigator.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';

class OnboardingViewModel extends ChangeNotifier {
  // hold data , handle logic
  late OnboardingNavigator navigator;
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void letsStartPressed() {
    if (formKey.currentState!.validate()) {
      // valid
      String name = nameController.text.trim();
      // save name to shared prefs
      SharedPrefs.getPrefs().setData(key: 'name', value: name);
      // navigate to home view
      navigator.navigateToHomeView();
    }
  }

  void showThemeBottomSheet() {
    navigator.showThemeBottomSheet();
  }

  void showLanguageBottomSheet() {
    navigator.showlanguageBottomSheet();
  }
}
