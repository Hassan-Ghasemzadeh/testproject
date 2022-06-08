import '../../core/utils/database_helper.dart';
import '../models/task.dart';

class SqfliteDataSource {
  final dbHelper = DatabaseHelper.instance;

  Future<List<Task>> insert(Task task) async {
    Map<String, dynamic> row = {
      'title': task.title,
      'description': task.description,
      'isDone': task.isDone == true ? 1 : 0,
      'category': task.category,
    };

    final integerId = await dbHelper.insert(row);
    task.id = integerId;
    final tasksList = await getAllTaskSqflite();
    return tasksList;
  }

  Future<List<Task>> update(Task task) async {
    if (task.id == null) {
      throw NullThrownError();
    }
    Map<String, dynamic> row = {
      'title': task.title,
      'description': task.description,
      'isDone': task.isDone == true ? 1 : 0,
      'category': task.category,
      'id': task.id
    };
    await dbHelper.update(row);
    final tasksList = await getAllTaskSqflite();
    return tasksList;
  }

  Future<List<Task>> delete(String title) async {
    await dbHelper.delete(title);
    final tasksList = await getAllTaskSqflite();
    return tasksList;
  }

  Future<List<Task>> getAllTaskSqflite() async {
    final tasksList = await dbHelper.queryAllRows();

    final result = tasksList.map((map) => Task.fromMapSql(map)).toList();

    return result;
  }

  Future<List<Task>> getTaskOnSpecificDate(String date) async {
    final tasksList = await getAllTaskSqflite();

    return tasksList.where((element) => element.dateCreated == date).toList();
  }
}
