import '../../core/utils/usecase_util/one_param_usecase_util.dart';
import '../../data/models/task.dart';
import '../repositories/task_repo_impl.dart';

class DeleteTaskUseCase extends UseCase<List<Task>, Task> {
  final TaskRepositoryImpl repo;

  DeleteTaskUseCase(this.repo);

  @override
  Future<List<Task>> invoke(Task p) async {
    return repo.delete(p);
  }
}
