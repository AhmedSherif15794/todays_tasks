import 'package:todays_tasks/models/task_model.dart';

abstract class TasksLocalDS {
  Future<List<TaskModel>> getTasks(DateTime date);
  void saveTasks(TaskModel task);
  void editTasks(DateTime date);
}
