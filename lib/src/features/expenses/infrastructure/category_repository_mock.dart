import 'package:async/async.dart';
import 'package:expense_tracker/src/features/expenses/domain/categories_repository.dart';
import 'package:expense_tracker/src/features/expenses/domain/category.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryRepositoryMock implements CategoryRepository {
  @override
  Future<Result<List<Category>>> fetch() {
    return Future(
      () => Result.value([
        Category(name: "food"),
        Category(name: "travel"),
      ]),
    );
  }
}

final categoryRepositoryMockProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryMock();
});
