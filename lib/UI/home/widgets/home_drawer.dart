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
          },
          child: Column(
            children: [
              // todays tasks header
              DrawerHeader(
                child: Center(
                  child: Text(
                    'Today\'s Tasks',
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
                  'Go To Home',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  // navigate to home

                  Navigator.pop(context);
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
