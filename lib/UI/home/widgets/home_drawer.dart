import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todays_tasks/UI/home/cubit/home_states.dart';
import 'package:todays_tasks/UI/home/cubit/home_view_model.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';
import 'package:todays_tasks/providers/app_language_provider.dart';
import 'package:todays_tasks/providers/app_theme_provider.dart';
import 'package:todays_tasks/utils/app_assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var viewModel = BlocProvider.of<HomeViewModel>(context);
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: BlocListener<HomeViewModel, HomeStates>(
          listener: (context, state) {
            if (state is HomeShowThemeBottomSheetState) {
              showModalBottomSheet(
                backgroundColor: Theme.of(context).cardColor,
                context: context,
                builder:
                    (context) => Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 24.h,
                        children: [
                          // light
                          TextButton(
                            onPressed: () {
                              // change theme
                              themeProvider.changeTheme(ThemeMode.light);
                              SharedPrefs.getPrefs().setData(
                                key: 'theme',
                                value: 'light',
                              );
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                side: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.light,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),

                          // dark
                          TextButton(
                            onPressed: () {
                              // change theme
                              themeProvider.changeTheme(ThemeMode.dark);
                              SharedPrefs.getPrefs().setData(
                                key: 'theme',
                                value: 'dark',
                              );
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                side: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.dark,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
              );
            }
            if (state is HomeShowLanguageBottomSheetState) {
              showModalBottomSheet(
                backgroundColor: Theme.of(context).cardColor,
                context: context,
                builder:
                    (context) => Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 24.h,
                        children: [
                          // arabic
                          TextButton(
                            onPressed: () {
                              // change theme
                              languageProvider.changeLanguage(
                                languageCode: 'ar',
                              );
                              SharedPrefs.getPrefs().setData(
                                key: 'language',
                                value: 'ar',
                              );
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                side: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.arabic,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),

                          // english
                          TextButton(
                            onPressed: () {
                              // change language
                              languageProvider.changeLanguage(
                                languageCode: 'en',
                              );
                              SharedPrefs.getPrefs().setData(
                                key: 'language',
                                value: 'en',
                              );
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                side: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.english,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
              );
            }
            if (state is HomeDateChangeState) {
              Navigator.pop(context);
            }
            if (state is HomeInitialState) {
              Navigator.pop(context);
            }
            if (state is ShowEditNameDialogState) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Theme.of(context).cardColor,
                    title: Text(
                      AppLocalizations.of(context)!.edit_name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    content: Column(
                      spacing: 12.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.name,
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                        // enter your name
                        Form(
                          key: viewModel.editNameFormKey,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.r),
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                left: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              controller: viewModel.editNameController,
                              style: Theme.of(context).textTheme.bodyMedium,

                              decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(
                                      context,
                                    )!.enter_your_name,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.please_enter_your_name;
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    actions: [
                      // save button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: TextButton(
                          onPressed: () {
                            // change name
                            viewModel.editName(
                              viewModel.editNameController.text,
                            );
                            // Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              side: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.save,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),

                      // cancek button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: TextButton(
                          onPressed: () {
                            // cancel
                            viewModel.editNameController.clear();
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              side: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Column(
            children: [
              // todays tasks header
              DrawerHeader(
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.todays_tasks,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
              ),

              // home
              ListTile(
                leading: Icon(
                  Icons.home_outlined,
                  color: Theme.of(context).primaryColorDark,
                ),
                title: Text(
                  AppLocalizations.of(context)!.go_to_home,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  // return to today
                  viewModel.returnToToday();
                },
              ),

              Divider(),

              // name
              BlocSelector<HomeViewModel, HomeStates, HomeInitialState>(
                selector:
                    (state) => HomeInitialState(
                      date: DateTime.now(),
                      name: SharedPrefs.getPrefs().getData(key: 'name'),
                    ),
                builder: (context, state) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.person_outline_outlined,
                          color: Theme.of(context).primaryColorDark,
                          size: 24.r,
                        ),
                        title:
                        // name
                        Text(
                          AppLocalizations.of(context)!.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),

                      // edit name
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: TextButton(
                          onPressed: () {
                            // change name
                            viewModel.showEditNameDialog();
                          },

                          child: Container(
                            padding: EdgeInsets.all(8.r),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.r),
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                left: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.name,
                                  style: Theme.of(context).textTheme.bodySmall!,
                                ),
                                Icon(
                                  Icons.edit_outlined,
                                  color: Theme.of(context).primaryColorDark,
                                  size: 24.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              Divider(),

              // theme
              ListTile(
                leading: SvgPicture.asset(
                  AppAssets.themeIcon,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColorDark,
                    BlendMode.srcIn,
                  ),
                ),
                title:
                // theme
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),

              // change theme button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextButton(
                  onPressed: () {
                    // change theme
                    viewModel.showThemeBottomSheet();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        themeProvider.isDarkMode()
                            ? AppLocalizations.of(context)!.dark
                            : AppLocalizations.of(context)!.light,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ],
                  ),
                ),
              ),

              Divider(),

              // language
              ListTile(
                leading: SvgPicture.asset(
                  AppAssets.languageIcon,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColorDark,
                    BlendMode.srcIn,
                  ),
                ),
                title:
                // theme
                Text(
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),

              // change language button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextButton(
                  onPressed: () {
                    // change language
                    viewModel.showLanguageBottomSheet();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        languageProvider.isArabic()
                            ? AppLocalizations.of(context)!.arabic
                            : AppLocalizations.of(context)!.english,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
