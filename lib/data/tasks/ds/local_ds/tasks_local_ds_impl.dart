import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:todays_tasks/data/tasks/ds/local_ds/tasks_local_ds.dart';
import 'package:todays_tasks/models/task_model.dart';

class TasksLocalDsImpl implements TasksLocalDS {
  @override
  void editTasks(DateTime date) {
    // TODO: implement editTasks
  }

  @override
  Future<List<TaskModel>> getTasks(DateTime date) async {
    try {
      var box = await Hive.openBox('tasks');
      return await box.get(date.toString()) ?? [];
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  void saveTasks(TaskModel task) async {
    try {
      var box = await Hive.openBox('tasks');
      List<TaskModel> tasks = [];
      tasks.add(task);
      await box.put(task.date.toString(), tasks);
      await box.close();
    } catch (e) {
      rethrow;
    }
  }
}
