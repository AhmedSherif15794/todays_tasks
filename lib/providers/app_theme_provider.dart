import 'package:flutter/material.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode themeMode =
      SharedPrefs.getPrefs().getData(key: "theme") != null
          ? SharedPrefs.getPrefs().getData(key: "theme") == "light"
              ? ThemeMode.light
              : ThemeMode.dark
          : ThemeMode.light;

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
