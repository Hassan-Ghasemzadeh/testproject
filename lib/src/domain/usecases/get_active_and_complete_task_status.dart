import 'package:testproject/src/core/utils/task_state.dart';

import '../../core/utils/usecase_util/no_param_usecase_util.dart';
import '../../data/models/task.dart';
import '../repositories/task_repo_impl.dart';

class GetStatusUseCase extends UseCase<List<Task>, TaskActiveAndCompleteState> {
  final TaskRepositoryImpl repo;

  GetStatusUseCase(this.repo);

  @override
  Future<TaskActiveAndCompleteState> invoke(List<Task> t) async {
    return repo.getActiveAndCompleteTaskState(t);
  }
}
