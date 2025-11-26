import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todays_tasks/UI/create_task/create_task_view.dart';
import 'package:todays_tasks/UI/edit_task/edit_task_view.dart';
import 'package:todays_tasks/UI/home/cubit/home_view_model.dart';
import 'package:todays_tasks/UI/onboarding/onboarding_view.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';
import 'package:todays_tasks/UI/home/home_view.dart';
import 'package:todays_tasks/data/tasks/ds/local_ds/tasks_local_ds_impl.dart';
import 'package:todays_tasks/data/tasks/repository/tasks_repo_impl.dart';
import 'package:todays_tasks/models/task_model.dart';
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
  final savingFolder = await getApplicationDocumentsDirectory();
  Hive.init(savingFolder.path);
  Hive.registerAdapter(TaskModelAdapter());
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

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool isOnboardingOpened =
      SharedPrefs.getPrefs().getData(key: 'name') != null ? true : false;
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return ScreenUtilInit(
      designSize: Size(392.7, 803.6),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,

      builder:
          (context, child) => OrientationBuilder(
            builder:
                (context, orientation) => BlocProvider(
                  create:
                      (context) => HomeViewModel(
                        tasksRepo: TasksRepoImpl(
                          tasksLocalDS: TasksLocalDsImpl(),
                        ),
                      ),
                  child: MaterialApp(
                    builder: (context, child) {
                      orientation = MediaQuery.of(context).orientation;

                      double scale =
                          orientation == Orientation.portrait ? 1.0 : 0.5;

                      return MediaQuery(
                        data: MediaQuery.of(
                          context,
                        ).copyWith(textScaler: TextScaler.linear(scale)),
                        child: child!,
                      );
                    },
                    title: "Todays Tasks",
                    // routes
                    routes: {
                      AppRoutes.homeView: (context) => HomeView(),
                      AppRoutes.onboarding: (context) => OnboardingView(),
                      AppRoutes.createTask: (context) => CreateTaskView(),
                      AppRoutes.editTask: (context) => EditTaskView(),
                    },
                    initialRoute:
                        isOnboardingOpened
                            ? AppRoutes.homeView
                            : AppRoutes.onboarding,

                    // Theme
                    themeMode: themeProvider.themeMode,
                    theme: AppTheme.lightTheme(),
                    darkTheme: AppTheme.darkTheme(),

                    // localization
                    locale: languageProvider.appLocale,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                  ),
                ),
          ),
    );
  }
}
