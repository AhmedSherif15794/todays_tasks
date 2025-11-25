import 'package:todays_tasks/data/tasks/ds/local_ds/tasks_local_ds.dart';
import 'package:todays_tasks/data/tasks/repository/tasks_repo.dart';
import 'package:todays_tasks/models/task_model.dart';

class TasksRepoImpl implements TasksRepo {
  TasksLocalDS tasksLocalDS;
  TasksRepoImpl({required this.tasksLocalDS});
  @override
  void editTask({
    required TaskModel task,
    required String title,
    required String description,
    required bool isCompleted,
  }) async {
    tasksLocalDS.editTask(
      task: task,
      title: title,
      description: description,
      isCompleted: isCompleted,
    );
  }

  @override
  Future<List<TaskModel>> getTasks(DateTime date) async {
    return await tasksLocalDS.getTasks(date);
  }

  @override
  void saveTask(TaskModel task) {
    tasksLocalDS.saveTasks(task);
  }

  @override
  void deleteTask(TaskModel task) {
    tasksLocalDS.deleteTask(task);
  }
}
