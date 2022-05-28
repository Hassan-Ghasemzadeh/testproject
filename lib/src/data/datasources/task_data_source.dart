import 'package:testproject/src/core/utils/task_state.dart';
import 'package:testproject/src/data/models/task.dart';

class TaskDataSource {
  Future<List<Task>> insert(List<Task> tasks, Task task) async {
    return List.from(tasks)..add(task);
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

    return TaskActiveAndCompleteState(
      activeTask: size - completedTaskCount,
      completedTask: completedTaskCount,
    );
  }
}
