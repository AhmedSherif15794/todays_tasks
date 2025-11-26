import 'package:hive/hive.dart';
import 'package:todays_tasks/caching/shared_prefs.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  // static int _counter = SharedPrefs.getPrefs().getData(key: 'counter') ?? 0;
  @HiveField(4)
  int id;
  @HiveField(0)
  String title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.date,
    this.description,
    this.isCompleted = false,
    required this.id,
  }) {
    // log("taskmodel id is : $id");
    // SharedPrefs.getPrefs().setData(key: 'counter', value: _counter);
    // id = _counter++;
  }
}

class IdGenerator {
  static int getNextId() {
    int counter = SharedPrefs.getPrefs().getData(key: 'counter') ?? 0;
    counter++;

    SharedPrefs.getPrefs().setData(key: 'counter', value: counter);

    return counter;
  }
}
