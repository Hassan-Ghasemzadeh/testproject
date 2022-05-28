import '../../core/utils/filter_task_state.dart';
import '../../core/utils/usecase_util/usecase.dart';
import '../../data/models/task.dart';
import '../repositories/task_repo_impl.dart';

class FilterTaskUseCase extends UseCase<List<Task>, FilterTaskState> {
  final TaskRepositoryImpl repo;

  FilterTaskUseCase(this.repo);
  @override
  Future<List<Task>> invoke(List<Task> t, FilterTaskState p) async {
    return repo.filterTaskList(t, p);
  }
}
