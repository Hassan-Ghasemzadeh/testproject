import 'package:testproject/src/data/models/task.dart';

import '../../core/utils/usecase_util/one_param_usecase_util.dart';
import '../repositories/task_repo_impl.dart';

class GetTaskDateCreatedUseCase extends UseCase<List<Task>, String> {
  final TaskRepositoryImpl repo;

  GetTaskDateCreatedUseCase(this.repo);

  @override
  Future<List<Task>> invoke(String p) async {
    return repo.getTaskOnSpecificDate(p);
  }
}
