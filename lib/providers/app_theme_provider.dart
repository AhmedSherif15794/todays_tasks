import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void changeTheme(ThemeMode theme) {
    if (themeMode == theme) {
      return;
    }
    themeMode = theme;
    notifyListeners();
  }

  bool isDarkMode() {
    if (themeMode == ThemeMode.dark) {
      return true;
    }
    return false;
  }
}
