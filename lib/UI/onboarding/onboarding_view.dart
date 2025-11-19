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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(22.r),
            child: Form(
              key: viewModel.formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 26.h,
                  children: [
                    SizedBox(),
                    // Image
                    Image.asset(
                      AppAssets.onboarding,
                      height: 200.h,
                      fit: BoxFit.contain,
                    ),
                    // Welcome to Today's Tasks!
                    Text(
                      AppLocalizations.of(context)!.welcome_to_todays_tasks,
                      style: Theme.of(context).textTheme.headlineLarge!,
                    ),

                    Text(
                      'Organize your daily tasks, capture ideas instsntly, and track your progress clearly.',
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlign: TextAlign.center,
                    ),

                    // name, theme & language container
                    Container(
                      padding: EdgeInsets.all(16.r),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12.h,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.name,
                              style: Theme.of(context).textTheme.bodyMedium!,
                            ),

                            TextFormField(
                              controller: viewModel.nameController,
                              style: Theme.of(context).textTheme.bodyMedium,

                              decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(
                                      context,
                                    )!.enter_your_name,
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

                            Divider(),

                            // theme & language
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.choose_your_settings,
                              style: Theme.of(context).textTheme.bodySmall!,
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
                                    Theme.of(context).primaryColorDark,
                                    BlendMode.srcIn,
                                  ),
                                ),

                                // theme
                                Text(
                                  AppLocalizations.of(context)!.theme,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),

                                Spacer(),
                                // select theme
                                TextButton(
                                  onPressed: () {
                                    viewModel.showThemeBottomSheet();
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: 32.w,
                                    children: [
                                      Text(
                                        themeProvider.isDarkMode()
                                            ? AppLocalizations.of(context)!.dark
                                            : AppLocalizations.of(
                                              context,
                                            )!.light,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                                    Theme.of(context).primaryColorDark,
                                    BlendMode.srcIn,
                                  ),
                                ),

                                // theme
                                Text(
                                  AppLocalizations.of(context)!.language,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Spacer(),
                                // select language
                                TextButton(
                                  onPressed: () {
                                    // show language bottom sheet
                                    viewModel.showLanguageBottomSheet();
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: 32.w,
                                    children: [
                                      Text(
                                        languageProvider.isArabic()
                                            ? AppLocalizations.of(
                                              context,
                                            )!.arabic
                                            : AppLocalizations.of(
                                              context,
                                            )!.english,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // let's start
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the next screen or home view
                          viewModel.letsStartPressed();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.lets_start,
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ],
                ),
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
