import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todays_tasks/UI/onboarding/onboarding_navigator.dart';
import 'package:todays_tasks/UI/onboarding/onboarding_view_model.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';
import 'package:todays_tasks/providers/app_language_provider.dart';
import 'package:todays_tasks/providers/app_theme_provider.dart';
import 'package:todays_tasks/utils/app_assets.dart';
import 'package:todays_tasks/utils/app_colors.dart';
import 'package:todays_tasks/utils/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    implements OnboardingNavigator {
  final OnboardingViewModel viewModel = OnboardingViewModel();
  @override
  void initState() {
    viewModel.navigator = this;
    super.initState();
  }

  @override
  void dispose() {
    viewModel.nameController.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0,

          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.list_alt_rounded,
                color: Theme.of(context).primaryColorDark,
                size: 28.sp,
              ),

              Text(
                AppLocalizations.of(context)!.todays_tasks,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),

        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Form(
            key: viewModel.formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 28.h,
                children: [
                  // Welcome to Today's Tasks!
                  Text(
                    AppLocalizations.of(context)!.welcome_to_todays_tasks,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.structure_your_thoughts_and_precisely_prioritize_your_daily_goals,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.instantly_record_fleeting_ideas_and_notes_to_review_later,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  Text(
                    AppLocalizations.of(
                      context,
                    )!.clearly_track_your_progress_and_achieve_your_goals_step_by_step,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 18.sp),
                  ),

                  // name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.whats_your_name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextFormField(
                        controller: viewModel.nameController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(2.r),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(2.r),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(2.r),
                            borderSide: BorderSide(color: AppColors.red),
                          ),
                          contentPadding: EdgeInsets.zero,
                          hintText:
                              AppLocalizations.of(context)!.enter_your_name,
                          hintStyle: Theme.of(
                            context,
                          ).textTheme.labelSmall!.copyWith(fontSize: 12.sp),
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
                    ],
                  ),

                  // theme & language
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10.h,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.choose_your_settings,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      // theme
                      Row(
                        spacing: 10.w,
                        children: [
                          // theme Icon
                          SvgPicture.asset(
                            AppAssets.themeIcon,
                            width: 20.w,
                            height: 20.h,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).primaryColor,
                              BlendMode.srcIn,
                            ),
                          ),

                          // theme
                          Text(
                            AppLocalizations.of(context)!.theme,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      // select theme
                      TextButton(
                        onPressed: () {
                          viewModel.showThemeBottomSheet();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8.w,
                          children: [
                            Text(
                              themeProvider.isDarkMode()
                                  ? AppLocalizations.of(context)!.dark
                                  : AppLocalizations.of(context)!.light,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),

                      // language
                      Row(
                        spacing: 10.w,
                        children: [
                          // language Icon
                          SvgPicture.asset(
                            AppAssets.languageIcon,
                            width: 20.w,
                            height: 20.h,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).primaryColor,
                              BlendMode.srcIn,
                            ),
                          ),

                          // theme
                          Text(
                            AppLocalizations.of(context)!.language,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),

                      // select language
                      TextButton(
                        onPressed: () {
                          // show language bottom sheet
                          viewModel.showLanguageBottomSheet();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8.w,
                          children: [
                            Text(
                              languageProvider.isArabic()
                                  ? AppLocalizations.of(context)!.arabic
                                  : AppLocalizations.of(context)!.english,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // let's start
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the next screen or home view
                      viewModel.letsStartPressed();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.lets_start,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void navigateToHomeView() {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.homeView, (route) => false);
  }

  @override
  void showThemeBottomSheet() {
    var themeProvider = Provider.of<AppThemeProvider>(context, listen: false);
    showModalBottomSheet(
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
                ElevatedButton(
                  onPressed: () {
                    themeProvider.changeTheme(ThemeMode.light);
                    SharedPrefs.getPrefs().setData(
                      key: 'theme',
                      value: 'light',
                    );
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.light),
                ),
                // dark
                ElevatedButton(
                  onPressed: () {
                    themeProvider.changeTheme(ThemeMode.dark);
                    SharedPrefs.getPrefs().setData(key: 'theme', value: 'dark');
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.dark),
                ),
              ],
            ),
          ),
    );
  }

  @override
  void showlanguageBottomSheet() {
    var languageProvider = Provider.of<AppLanguageProvider>(
      context,
      listen: false,
    );
    showModalBottomSheet(
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
                ElevatedButton(
                  onPressed: () {
                    languageProvider.changeLanguage(languageCode: 'ar');
                    SharedPrefs.getPrefs().setData(
                      key: 'language',
                      value: 'ar',
                    );
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.arabic),
                ),
                // dark
                ElevatedButton(
                  onPressed: () {
                    languageProvider.changeLanguage(languageCode: 'en');
                    SharedPrefs.getPrefs().setData(
                      key: 'language',
                      value: 'en',
                    );
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.english),
                ),
              ],
            ),
          ),
    );
  }
}
