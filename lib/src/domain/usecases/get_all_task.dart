import 'package:get_it/get_it.dart';
import 'package:testproject/src/core/utils/shared_pref_util.dart';

import '../../core/utils/usecase_util/no_param_usecase.dart';
import '../../data/models/task.dart';
import '../repositories/task_repo_impl.dart';

class GetAllTaskHiveOrSqf extends UseCase<List<Task>> {
  final TaskRepositoryImpl repo;

  GetAllTaskHiveOrSqf(this.repo);
  @override
  Future<List<Task>> invoke() async {
    final util = GetIt.I.get<SharedPrefUtil>();
    final text = await util.getStringValuesSF();

    if (text == 'Hive') {
      return repo.getAllTaskHive();
    } else {
      return repo.getAllTaskSqf();
    }
  }
}
