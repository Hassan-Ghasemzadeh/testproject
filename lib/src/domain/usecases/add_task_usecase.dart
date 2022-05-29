import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/domain/repositories/task_repo_impl.dart';

import '../../core/utils/usecase_util/one_param_usecase_util.dart';

class AddTaskUseCase extends UseCase<List<Task>, Task> {
  final TaskRepositoryImpl repo;

  AddTaskUseCase(this.repo);
  @override
  Future<List<Task>> invoke(Task p) async {
    return repo.insert(p);
  }
}
