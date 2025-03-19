import 'package:async/async.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';
import 'package:expense_tracker/src/features/expenses/domain/expenses_repository.dart';
import 'package:expense_tracker/src/features/expenses/infrastructure/expenses_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpensesListNotifier extends StateNotifier<AsyncValue<List<Expense>>> {
  final AutoDisposeStateNotifierProviderRef _ref;

  ExpensesListNotifier({required AutoDisposeStateNotifierProviderRef ref})
      : _ref = ref,
        super(const AsyncLoading()) {
    load();
  }

  late final ExpensesRepository expensesRepository =
      _ref.read(expensesRepositoryProvider);

  void load() async {
    final result = await expensesRepository.fetch();

    if (result.isValue) {
      state = AsyncData(result.asValue!.value);
    } else if (result.isError) {
      state =
          AsyncValue.error(result.asError!.error, result.asError!.stackTrace);
    }
  }

  Future<Result<bool>> create(Expense expense) async {
    final result = await expensesRepository.create(expense);
    return result;
  }
}

final expensesListViewModelProvider = StateNotifierProvider.autoDispose<
    ExpensesListNotifier,
    AsyncValue<List<Expense>>>((ref) => ExpensesListNotifier(ref: ref));
