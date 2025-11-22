import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  bool? isCompleted;

  TaskModel({
    required this.title,
    required this.date,
    this.description,
    this.isCompleted = false,
  });
}
