import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:todays_tasks/data/tasks/ds/local_ds/tasks_local_ds.dart';
import 'package:todays_tasks/models/task_model.dart';

class TasksLocalDsImpl implements TasksLocalDS {
  @override
  void editTask({
    required TaskModel task,
    required String title,
    required String description,
    required bool isCompleted,
  }) async {
    String formatedDate = task.date.toString().substring(0, 10);
    try {
      // open the box
      var box = await Hive.openBox('tasks');
      // get the tasks list
      List<TaskModel> tasks = box.get(formatedDate)?.cast<TaskModel>() ?? [];
      // get the task
      TaskModel myTask = tasks.firstWhere((element) => element.id == task.id);
      // get the index of the task
      int index = tasks.indexOf(myTask);
      // remove the task from the list
      tasks.remove(myTask);
      // update the task
      myTask.title = title;
      myTask.description = description;
      myTask.isCompleted = isCompleted;
      // add the task to the list at the same index
      tasks.insert(index, myTask);
      // add the list at the same key(replace the old one by the new one)
      await box.put(formatedDate, tasks);
    } catch (e) {
      log('edit tasks error : $e');
      rethrow;
    }
  }

  @override
  Future<List<TaskModel>> getTasks(DateTime date) async {
    String formatedDate = date.toString().substring(0, 10);
    try {
      // open the box
      var box = await Hive.openBox('tasks');
      // get the tasks
      List<TaskModel> tasks = box.get(formatedDate)?.cast<TaskModel>() ?? [];

      return tasks;
      // return await box.get(date.toString()) ?? [];
    } catch (e) {
      log('get tasks error : $e');
      rethrow;
    }
  }

  @override
  void saveTasks(TaskModel task) async {
    String formatedDate = task.date.toString().substring(0, 10);
    try {
      // open the box
      var box = await Hive.openBox('tasks');
      // get the tasks list
      List<TaskModel> tasks = box.get(formatedDate)?.cast<TaskModel>() ?? [];
      // add the task to the list
      tasks.add(task);
      // replace the old list by the new one
      await box.put(formatedDate, tasks);
    } catch (e) {
      log('save tasks error : $e');
      rethrow;
    }
  }

  @override
  void deleteTask(TaskModel task) async {
    String formatedDate = task.date.toString().substring(0, 10);

    try {
      // open the box
      var box = await Hive.openBox('tasks');
      // get the list
      List<TaskModel> tasks = box.get(formatedDate)?.cast<TaskModel>() ?? [];
      // delete our task from the list
      tasks.remove(task);
      // replace the new list by the old one
      await box.put(formatedDate, tasks);
    } catch (e) {
      log("delete task error:  $e");
      rethrow;
    }
  }
}
