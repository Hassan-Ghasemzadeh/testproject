import 'package:testproject/src/core/utils/task_state.dart';
import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/data/models/task_category.dart';
import 'package:testproject/src/data/repositories/base_repository.dart';
import 'package:testproject/src/data/datasources/task_data_source.dart';

class TaskRepositoryImpl extends ITaskRepository {
  final source = TaskDataSource();
  @override
  Future<List<Task>> insert(Task task) async {
    return source.insert(task);
  }

  @override
  Future<List<Task>> toggleCheckBox(Task task) async {
    return source.toggleCheckBox(task);
  }

  @override
  Future<List<Task>> delete(Task task) async {
    return source.delete(task);
  }

  @override
  Future<TaskActiveAndCompleteState> getActiveAndCompleteTaskState() async {
    return source.getActiveAndCompleteTaskState();
  }

  @override
  Future<List<Category>> insertCategory(List<Category> category, Category ctg) {
    return source.insertCategory(category, ctg);
  }

  @override
  Future<List<Task>> filterTaskList(
      {required String currentFilter, required String currentCategory}) {
    return source.filterCategory(
        currentFilter: currentFilter, currentCategory: currentCategory);
  }
}
