import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';
import 'package:todays_tasks/home/home_view.dart';
import 'package:todays_tasks/providers/app_theme_provider.dart';
import 'package:todays_tasks/utils/app_routes.dart';
import 'package:todays_tasks/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      title: "Todays Tasks",
      // routes
      routes: {AppRoutes.homeView: (context) => HomeView()},
      initialRoute: AppRoutes.homeView,

      // Theme
      themeMode: themeProvider.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
