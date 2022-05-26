import 'package:testproject/src/core/utils/usecase_util/usecase.dart';
import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/domain/repositories/task_repo_impl.dart';

class AddTaskUseCase extends UseCase<List<Task>, Task> {
  final TaskRepositoryImpl repo;

  AddTaskUseCase(this.repo);
  @override
  Future<List<Task>> invoke(List<Task> t, Task p) async {
    return repo.insert(t, p);
  }
}
