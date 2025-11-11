import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todays_tasks/providers/app_theme_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Tasks"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.isDarkMode()
                  ? themeProvider.changeTheme(ThemeMode.light)
                  : themeProvider.changeTheme(ThemeMode.dark);
            },
            icon: Icon(Icons.change_circle_outlined),
          ),
        ],
      ),
    );
  }
}
