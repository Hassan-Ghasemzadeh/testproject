import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class HiveDataSource {
  final box = GetIt.I.get<Box<Task>>();
  Future<List<Task>> insert(Task task) async {
    await box.add(task);
    return box.values.toList();
  }

  Future<List<Task>> delete(Task task) async {
    await box.delete(task.key);

    return box.values.toList();
  }

  Future<List<Task>> getTaskOnSpecificDate(String date) async {
    return box.values.where((element) => element.dateCreated == date).toList();
  }

  Future<List<Task>> getAllTaskHive() async {
    return box.values.toList();
  }

  Future<void> toggleCheckbox(Task task) async {
    await box.put(task.key, task.copyWith(isDone: !task.isDone!));
  }
}
