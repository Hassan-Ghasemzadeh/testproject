import 'package:testproject/src/core/utils/task_state.dart';
import 'package:testproject/src/core/utils/value_setter.dart';
import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/data/models/task_category.dart';

class TaskDataSource {
  static List<Task> tasksList = const <Task>[];

  Future<List<Task>> insert(Task task) async {
    tasksList = List.from(tasksList)
      ..setValueWhere((e) => e.id == task.id, task, true);
    return tasksList;
  }

  Future<List<Task>> toggleCheckBox(Task task) async {
    final index = tasksList.indexOf(task);

    task.isDone == false
        ? tasksList.insert(index, task.copyWith(isDone: true))
        : tasksList.insert(index, task.copyWith(isDone: false));

    tasksList = List.of(tasksList)..remove(task);
    return tasksList;
  }

  Future<List<Task>> delete(Task task) async {
    tasksList = List.from(tasksList)..remove(task);
    return tasksList;
  }

  Future<TaskActiveAndCompleteState> getActiveAndCompleteTaskState() async {
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
  }

  Future<List<Category>> insertCategory(
      List<Category> ctg, Category category) async {
    return List.of(ctg)
      ..setValueWhere((e) => e.id == category.id, category, true);
  }

  Future<List<Task>> filterCategory(
      {required String currentFilter, required String currentCategory}) async {
    List<Task> filteredTasks = <Task>[];
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
  }

  Future<List<Task>> getTaskOnSpecificDate(String date) async {
    return tasksList.where((element) => element.dateCreated == date).toList();
  }
}
