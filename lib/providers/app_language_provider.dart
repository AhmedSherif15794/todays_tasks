import 'package:flutter/material.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';

class AppLanguageProvider extends ChangeNotifier {
  Locale appLocale =
      SharedPrefs.getPrefs().getData(key: "language") != null
          ? SharedPrefs.getPrefs().getData(key: "language") == 'ar'
              ? Locale('ar')
              : Locale('en')
          : Locale('en');

  void changeLanguage({required String languageCode}) {
    if (appLocale.languageCode == languageCode) {
      return;
    }
    appLocale = Locale(languageCode);
    notifyListeners();
  }

  bool isArabic() {
    if (appLocale.languageCode == 'ar') {
      return true;
    }
    return false;
  }
}
