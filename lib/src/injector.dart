import 'package:get_it/get_it.dart';
import 'package:testproject/src/domain/repositories/task_repo_impl.dart';

final GetIt injector = GetIt.instance;

void setUp() {
  injector.registerSingleton<TaskRepositoryImpl>(TaskRepositoryImpl());
}
