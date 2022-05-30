import 'package:testproject/src/core/utils/task_state.dart';
import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/data/models/task_category.dart';

abstract class ITaskRepository {
  Future<List<Task>> insert(Task task);

  Future<List<Task>> toggleCheckBox(Task task);

  Future<List<Task>> delete(Task task);

  Future<TaskActiveAndCompleteState> getActiveAndCompleteTaskState();

  Future<List<Category>> insertCategory(List<Category> category, Category ctg);

  Future<List<Task>> filterTaskList(
      {required String currentFilter, required String currentCategory});

  Future<List<Task>> getTaskOnSpecificDate(String date);
}
