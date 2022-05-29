import 'package:testproject/src/core/utils/task_state.dart';
import 'package:testproject/src/core/utils/value_setter.dart';
import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/data/models/task_category.dart';

class TaskDataSource {
  Future<List<Task>> insert(List<Task> tasks, Task task) async {
    return List.from(tasks)..setValueWhere((e) => e.id == task.id, task, true);
  }

  Future<List<Task>> toggleCheckBox(List<Task> tasks, Task task) async {
    final index = tasks.indexOf(task);

    task.isDone == false
        ? tasks.insert(index, task.copyWith(isDone: true))
        : tasks.insert(index, task.copyWith(isDone: false));

    List<Task> list = List.of(tasks)..remove(task);
    return list;
  }

  Future<List<Task>> delete(List<Task> tasks, Task task) async {
    return List.from(tasks)..remove(task);
  }

  Future<TaskActiveAndCompleteState> getActiveAndCompleteTaskState(
      List<Task> tasks) async {
    var size = tasks.length;
    final List<Task> completed =
        tasks.where((element) => element.isDone!).toList();

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
      {required List<Task> tasks,
      required String currentFilter,
      required String currentCategory}) async {
    List<Task> filteredTasks = <Task>[];
    switch (currentFilter) {
      case 'All':
        filteredTasks = tasks;
        break;
      case 'Active':
        filteredTasks = tasks.where((element) {
          return element.isDone == false;
        }).toList();
        break;
      case 'Completed':
        filteredTasks = tasks.where((element) {
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
