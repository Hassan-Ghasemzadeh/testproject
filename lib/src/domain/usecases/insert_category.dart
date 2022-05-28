// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:testproject/src/data/models/task_category.dart';
import 'package:testproject/src/domain/repositories/task_repo_impl.dart';

import '../../core/utils/usecase_util/usecase.dart';

class InsertCategoryUsecase extends UseCase<List<Category>, Category> {
  final TaskRepositoryImpl repo;
  InsertCategoryUsecase({
    required this.repo,
  });

  @override
  Future<List<Category>> invoke(List<Category> t, Category p) {
    return repo.insertCategory(t, p);
  }
}
