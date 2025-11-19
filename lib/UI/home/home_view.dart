import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todays_tasks/UI/home/cubit/home_states.dart';
import 'package:todays_tasks/UI/home/cubit/home_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    // var themeProvider = Provider.of<AppThemeProvider>(context);
    // var languageProvider = Provider.of<AppLanguageProvider>(context);
    log("orientation = ${MediaQuery.of(context).orientation}");
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(AppLocalizations.of(context)!.todays_tasks),
      //   centerTitle: true,
      //   actions: [
      //     // theme
      //     IconButton(
      //       onPressed: () {
      //         if (themeProvider.isDarkMode()) {
      //           themeProvider.changeTheme(ThemeMode.light);
      //           SharedPrefs.getPrefs().setData(key: "theme", value: "light");
      //         } else {
      //           themeProvider.changeTheme(ThemeMode.dark);
      //           SharedPrefs.getPrefs().setData(key: "theme", value: "dark");
      //         }
      //       },
      //       icon: Icon(Icons.color_lens_outlined),
      //     ),
      //     // language
      //     IconButton(
      //       onPressed: () {
      //         if (languageProvider.isArabic()) {
      //           languageProvider.changeLanguage(languageCode: 'en');
      //           SharedPrefs.getPrefs().setData(key: "language", value: "en");
      //         } else {
      //           languageProvider.changeLanguage(languageCode: 'ar');
      //           SharedPrefs.getPrefs().setData(key: "language", value: "ar");
      //         }
      //       },
      //       icon: Icon(Icons.language_outlined),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => viewModel,
          child: Padding(
            padding: EdgeInsets.all(32.r),
            child: Column(
              spacing: 16.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // welcome text
                BlocSelector<HomeViewModel, HomeStates, HomeInitialState>(
                  selector: (state) {
                    return HomeInitialState(date: DateTime.now());
                  },
                  builder: (context, state) {
                    if (state.date.hour > 0 && state.date.hour < 12) {
                      return Text(
                        "Good Morning, \n${viewModel.name}",
                        style: Theme.of(context).textTheme.headlineLarge,
                      );
                    } else if (state.date.hour >= 12 && state.date.hour < 17) {
                      return Text(
                        "Good Afternoon, \n${viewModel.name}",
                        style: Theme.of(context).textTheme.headlineLarge,
                      );
                    } else {
                      return Text(
                        "Good Evening, \n${viewModel.name}",
                        style: Theme.of(context).textTheme.headlineLarge,
                      );
                    }
                  },
                ),

                // date
                BlocConsumer<HomeViewModel, HomeStates>(
                  listener: (context, state) async {
                    if (state is HomeShowDatePickerState) {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        firstDate: viewModel.selectedDate.subtract(
                          Duration(days: 365),
                        ),
                        lastDate: viewModel.selectedDate.add(
                          Duration(days: 365),
                        ),
                        initialDate: viewModel.selectedDate,
                      );
                      if (pickedDate != null) {
                        viewModel.updateSelectedDate(pickedDate);
                      }
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // back
                        IconButton(
                          onPressed: () {
                            // go to previous date
                            viewModel.goToPreviousDay();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),

                        // date
                        GestureDetector(
                          onLongPress: () {
                            // open date picker
                            viewModel.showDatePicker();
                          },
                          onDoubleTap: () {
                            // return to today
                            viewModel.returnToToday();
                          },
                          child: Text(
                            DateFormat.MMMEd().format(viewModel.selectedDate),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        // forward
                        IconButton(
                          onPressed: () {
                            // go to next date
                            viewModel.goToNextDay();
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
