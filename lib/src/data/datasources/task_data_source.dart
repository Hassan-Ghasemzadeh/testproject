import 'package:testproject/src/core/utils/value_setter.dart';
import 'package:testproject/src/data/models/task.dart';

class TaskDataSource {
  static List<Task> tasksList = <Task>[];

  Future<List<Task>> insert(Task task) async {
    tasksList = List.from(tasksList)
      ..setValueWhere((e) => e.taskId == task.taskId, task, true);
    return tasksList;
  }

  Future<List<Task>> delete(Task task) async {
    tasksList = List.from(tasksList)..remove(task);
    return tasksList;
  }

  Future<List<Task>> getTaskOnSpecificDate(String date) async {
    return tasksList.where((element) => element.dateCreated == date).toList();
  }
}
