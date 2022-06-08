import 'package:testproject/src/core/utils/shared_pref_util.dart';
import 'package:testproject/src/core/utils/task_state.dart';
import 'package:testproject/src/data/datasources/hive_datasource.dart';
import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/data/repositories/base_repository.dart';
import 'package:testproject/src/data/datasources/task_data_source.dart';

import '../../data/datasources/sqflite_datasource.dart';

class TaskRepositoryImpl extends ITaskRepository {
  final TaskDataSource source;
  final HiveDataSource hiveSource;
  final SqfliteDataSource sqfliteSource;
  final SharedPrefUtil util;
  List<Task> get tasksList => TaskDataSource.tasksList;
  TaskRepositoryImpl(
    this.source,
    this.util,
    this.hiveSource,
    this.sqfliteSource,
  );

  @override
  Future<List<Task>> insert(Task task) async {
    final text = await util.getStringValuesSF();
    if (text == 'Local database') {
      return source.insert(task);
    } else if (text == 'Hive') {
      final s = await hiveSource.insert(task);
      return s;
    } else {
      return sqfliteSource.insert(task);
    }
  }

  @override
  Future<List<Task>> toggleCheckBox(Task task) async {
    final text = await util.getStringValuesSF();
    if (text == 'Local database') {
      return source.insert(task.copyWith(isDone: task.isDone == false));
    } else if (text == 'Hive') {
      hiveSource.toggleCheckbox(task);
      return [];
    } else {
      return sqfliteSource.update(task.copyWith(isDone: task.isDone == false));
    }
  }

  @override
  Future<List<Task>> delete(Task task) async {
    final text = await util.getStringValuesSF();
    if (text == 'Local database') {
      return source.delete(task);
    } else if (text == 'Hive') {
      return hiveSource.delete(task);
    } else {
      return sqfliteSource.delete(task.title);
    }
  }

  @override
  Future<TaskActiveAndCompleteState> getActiveAndCompleteTaskState() async {
    final text = await util.getStringValuesSF();
    final hiveList = await hiveSource.getAllTaskHive();
    final sqfList = await sqfliteSource.getAllTaskSqflite();
    if (text == 'Local database') {
      var size = tasksList.length;
      final List<Task> completed =
          tasksList.where((element) => element.isDone!).toList();

      final int completedTaskCount = completed.length;
      if (size == 0) {
        return const TaskActiveAndCompleteState(
          activeTaskPercent: 0,
          completedTaskPercent: 0,
        );
      }
      return TaskActiveAndCompleteState(
        activeTaskPercent: 100 * (size - completedTaskCount) / size,
        completedTaskPercent: 100 * completedTaskCount / size,
      );
    } else if (text == 'Hive') {
      var size = hiveList.length;
      final List<Task> completed =
          hiveList.where((element) => element.isDone!).toList();

      final int completedTaskCount = completed.length;
      if (size == 0) {
        return const TaskActiveAndCompleteState(
          activeTaskPercent: 0,
          completedTaskPercent: 0,
        );
      }
      return TaskActiveAndCompleteState(
        activeTaskPercent: 100 * (size - completedTaskCount) / size,
        completedTaskPercent: 100 * completedTaskCount / size,
      );
    } else {
      var size = sqfList.length;
      final List<Task> completed =
          sqfList.where((element) => element.isDone!).toList();

      final int completedTaskCount = completed.length;
      if (size == 0) {
        return const TaskActiveAndCompleteState(
          activeTaskPercent: 0,
          completedTaskPercent: 0,
        );
      }
      return TaskActiveAndCompleteState(
        activeTaskPercent: 100 * (size - completedTaskCount) / size,
        completedTaskPercent: 100 * completedTaskCount / size,
      );
    }
  }

  @override
  Future<List<Task>> filterTaskList(
      {required String currentFilter, required String currentCategory}) async {
    List<Task> filteredTasks = <Task>[];
    List<Task> list = await getAllTaskHive();
    final text = await util.getStringValuesSF();
    final sqfList = await sqfliteSource.getAllTaskSqflite();

    if (text == 'Local database') {
      switch (currentFilter) {
        case 'All':
          filteredTasks = tasksList;
          break;
        case 'Active':
          filteredTasks = tasksList.where((element) {
            return element.isDone == false;
          }).toList();
          break;
        case 'Completed':
          filteredTasks = tasksList.where((element) {
            return element.isDone == true;
          }).toList();
          break;
      }

      if (currentCategory != 'All') {
        filteredTasks = filteredTasks.where((element) {
          return element.category == currentCategory;
        }).toList();
      }
      return filteredTasks;
    } else if (text == 'Hive') {
      switch (currentFilter) {
        case 'All':
          filteredTasks = list;
          break;
        case 'Active':
          filteredTasks = list.where((element) {
            return element.isDone == false;
          }).toList();
          break;
        case 'Completed':
          filteredTasks = list.where((element) {
            return element.isDone == true;
          }).toList();
          break;
      }

      if (currentCategory != 'All') {
        filteredTasks = filteredTasks.where((element) {
          return element.category == currentCategory;
        }).toList();
      }
      return filteredTasks;
    } else {
      switch (currentFilter) {
        case 'All':
          filteredTasks = sqfList;
          break;
        case 'Active':
          filteredTasks = sqfList.where((element) {
            return element.isDone == false;
          }).toList();
          break;
        case 'Completed':
          filteredTasks = sqfList.where((element) {
            return element.isDone == true;
          }).toList();
          break;
      }

      if (currentCategory != 'All') {
        filteredTasks = filteredTasks.where((element) {
          return element.category == currentCategory;
        }).toList();
      }
      return filteredTasks;
    }
  }

  @override
  Future<List<Task>> getTaskOnSpecificDate(String date) async {
    final text = await util.getStringValuesSF();
    if (text == 'Local database') {
      return source.getTaskOnSpecificDate(date);
    } else if (text == 'Hive') {
      return hiveSource.getTaskOnSpecificDate(date);
    } else {
      return sqfliteSource.getTaskOnSpecificDate(date);
    }
  }

  @override
  Future<List<Task>> getAllTaskHive() async {
    return hiveSource.getAllTaskHive();
  }

  @override
  Future<List<Task>> getAllTaskSqf() {
    return sqfliteSource.getAllTaskSqflite();
  }
}
