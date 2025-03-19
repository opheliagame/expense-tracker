import 'package:expense_tracker/src/features/expenses/domain/categories_repository.dart';
import 'package:expense_tracker/src/features/expenses/domain/category.dart';
import 'package:expense_tracker/src/features/expenses/infrastructure/category_repository_mock.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryListNotifier extends StateNotifier<AsyncValue<List<Category>>> {
  CategoryListNotifier({required this.categoryRepository})
      : super(const AsyncLoading()) {
    load();
  }

  final CategoryRepository categoryRepository;

  Future<void> load() async {
    final result = await categoryRepository.fetch();

    if (result.isValue) {
      state = AsyncData(result.asValue!.value);
    } else if (result.isError) {
      state =
          AsyncValue.error(result.asError!.error, result.asError!.stackTrace);
    }
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoryListNotifier, AsyncValue<List<Category>>>(
        (ref) {
  return CategoryListNotifier(
      categoryRepository: ref.read(categoryRepositoryMockProvider));
});
