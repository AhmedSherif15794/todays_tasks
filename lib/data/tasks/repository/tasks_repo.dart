import 'package:todays_tasks/models/task_model.dart';

abstract class TasksRepo {
  Future<List<TaskModel>> getTasks(DateTime date);
  void saveTask(TaskModel task);
  void editTasks(DateTime date);
}
