import 'package:testproject/src/core/utils/task_state.dart';
import 'package:testproject/src/data/models/task.dart';

abstract class ITaskRepository {
  Future<List<Task>> insert(Task task);

  Future<List<Task>> toggleCheckBox(Task task);

  Future<List<Task>> delete(Task task);

  Future<TaskActiveAndCompleteState> getActiveAndCompleteTaskState();

  Future<List<Task>> filterTaskList(
      {required String currentFilter, required String currentCategory});

  Future<List<Task>> getTaskOnSpecificDate(String date);

  Future<List<Task>> getAllTaskHive();

  Future<List<Task>> getAllTaskSqf();
}
