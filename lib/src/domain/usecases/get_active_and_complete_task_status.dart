import 'package:testproject/src/core/utils/task_state.dart';

import '../../core/utils/usecase_util/no_param_usecase.dart';
import '../repositories/task_repo_impl.dart';

class GetStatusUseCase extends UseCase<TaskActiveAndCompleteState> {
  final TaskRepositoryImpl repo;

  GetStatusUseCase(this.repo);

  @override
  Future<TaskActiveAndCompleteState> invoke() async {
    return repo.getActiveAndCompleteTaskState();
  }
}
