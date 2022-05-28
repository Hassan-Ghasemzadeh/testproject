import '../../core/utils/usecase_util/three_param_usecase.dart';
import '../../data/models/task.dart';
import '../repositories/task_repo_impl.dart';

class FilterTaskUseCase extends UseCase<List<Task>, String, String> {
  final TaskRepositoryImpl repo;

  FilterTaskUseCase(this.repo);
  @override
  Future<List<Task>> invoke(List<Task> t, String p, String d) async {
    return repo.filterTaskList(t, p, d);
  }
}
