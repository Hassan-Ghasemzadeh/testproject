import 'package:testproject/src/core/utils/task_state.dart';
import 'package:testproject/src/data/models/task.dart';

abstract class ITaskRepository {
  Future<List<Task>> insert(List<Task> tasks, Task task);

  Future<List<Task>> toggleCheckBox(List<Task> tasks, Task task);

  Future<List<Task>> delete(List<Task> tasks, Task task);

  Future<TaskActiveAndCompleteState> getActiveAndCompleteTaskState(
      List<Task> tasks);
}
