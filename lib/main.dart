import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todays_tasks/UI/onboarding/onboarding_view.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';
import 'package:todays_tasks/UI/home/home_view.dart';
import 'package:todays_tasks/providers/app_language_provider.dart';
import 'package:todays_tasks/providers/app_theme_provider.dart';
import 'package:todays_tasks/utils/app_routes.dart';
import 'package:todays_tasks/utils/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todays_tasks/utils/my_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool isOnboardingOpened =
      SharedPrefs.getPrefs().getData(key: 'name') != null ? true : false;
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return ScreenUtilInit(
      designSize: Size(411.4, 866.3),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => MaterialApp(
            title: "Todays Tasks",
            // routes
            routes: {
              AppRoutes.homeView: (context) => HomeView(),
              AppRoutes.onboarding: (context) => OnboardingView(),
            },
            initialRoute:
                isOnboardingOpened ? AppRoutes.homeView : AppRoutes.onboarding,

            // Theme
            themeMode: themeProvider.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,

            // localization
            locale: languageProvider.appLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
    );
  }
}
