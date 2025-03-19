import 'package:async/async.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';
import 'package:expense_tracker/src/features/expenses/domain/expenses_repository.dart';
import 'package:expense_tracker/src/features/expenses/infrastructure/expense_repository_mock.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpensesListNotifier extends StateNotifier<AsyncValue<List<Expense>>> {
  ExpensesListNotifier({required this.expensesRepository})
      : super(const AsyncLoading()) {
    load();
  }

  final ExpenseRepository expensesRepository;

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
    ExpensesListNotifier, AsyncValue<List<Expense>>>(
  (ref) => ExpensesListNotifier(
    expensesRepository: ref.read(expenseRepositoryMockProvider),
  ),
);
