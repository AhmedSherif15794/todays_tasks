import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';
import 'package:todays_tasks/providers/app_language_provider.dart';
import 'package:todays_tasks/providers/app_theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    // var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.todays_tasks),
        centerTitle: true,
        actions: [
          // theme
          IconButton(
            onPressed: () {
              if (themeProvider.isDarkMode()) {
                themeProvider.changeTheme(ThemeMode.light);
                SharedPrefs.setData(key: "theme", value: "light");
              } else {
                themeProvider.changeTheme(ThemeMode.dark);
                SharedPrefs.setData(key: "theme", value: "dark");
              }
            },
            icon: Icon(Icons.color_lens_outlined),
          ),
          // language
          IconButton(
            onPressed: () {
              if (languageProvider.isArabic()) {
                languageProvider.changeLanguage(languageCode: 'en');
                SharedPrefs.setData(key: "language", value: "en");
              } else {
                languageProvider.changeLanguage(languageCode: 'ar');
                SharedPrefs.setData(key: "language", value: "ar");
              }
            },
            icon: Icon(Icons.language_outlined),
          ),
        ],
      ),
    );
  }
}
