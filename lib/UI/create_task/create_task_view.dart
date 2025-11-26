import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todays_tasks/UI/home/cubit/home_states.dart';
import 'package:todays_tasks/UI/home/cubit/home_view_model.dart';
import 'package:todays_tasks/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  late final HomeViewModel homeViewModel;
  @override
  void initState() {
    homeViewModel = BlocProvider.of<HomeViewModel>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    homeViewModel.createTaskTitleController.clear();
    homeViewModel.createTaskDescriptionController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.create_task,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<HomeViewModel, HomeStates>(
        builder: (context, state) {
          if (state is GoTocreateView) {
            // Save Edits
            return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child:
                // save task
                ElevatedButton(
                  onPressed: () {
                    homeViewModel.saveTask();
                    // Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.save_task),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
      body: Form(
        key: homeViewModel.createTaskFormKey,
        child: Padding(
          padding: EdgeInsets.all(32.r),
          child: BlocListener<HomeViewModel, HomeStates>(
            listener: (context, state) {
              if (state is TaskSuccessSavedState) {
                // navigate to home screen
                Navigator.pop(context);
              }
            },

            child: SingleChildScrollView(
              child: Column(
                spacing: 8.h,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.task_title,
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  // enter your title
                  TextFormField(
                    controller: homeViewModel.createTaskTitleController,
                    style: Theme.of(context).textTheme.bodyMedium,

                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.enter_task_title,
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(
                          context,
                        )!.please_enter_task_title;
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 22.h),

                  // description
                  Text(
                    AppLocalizations.of(context)!.description,
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  // descripe_your_task
                  TextFormField(
                    controller: homeViewModel.createTaskDescriptionController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 6,
                    minLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)!.descripe_your_task,
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
}
