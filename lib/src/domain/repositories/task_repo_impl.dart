import 'package:testproject/src/core/utils/task_state.dart';
import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/data/repositories/base_repository.dart';
import 'package:testproject/src/data/datasources/task_data_source.dart';

class TaskRepositoryImpl extends ITaskRepository {
  final source = TaskDataSource();
  @override
  Future<List<Task>> insert(List<Task> tasks, Task task) async {
    return source.insert(tasks, task);
  }

  @override
  Future<List<Task>> toggleCheckBox(List<Task> tasks, Task task) async {
    return source.toggleCheckBox(tasks, task);
  }

  @override
  Future<List<Task>> delete(List<Task> tasks, Task task) async {
    return source.delete(tasks, task);
  }

  @override
  Future<TaskActiveAndCompleteState> getActiveAndCompleteTaskState(
      List<Task> tasks) async {
    return source.getActiveAndCompleteTaskState(tasks);
  }
}
