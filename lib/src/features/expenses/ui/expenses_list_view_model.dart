import 'package:async/async.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';
import 'package:expense_tracker/src/features/expenses/domain/expenses_repository.dart';
import 'package:expense_tracker/src/features/expenses/infrastructure/expense_repository_mock.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpensesListNotifier
    extends StateNotifier<AsyncValue<ExpensesListWithTotal>> {
  ExpensesListNotifier({required this.expensesRepository})
      : super(const AsyncLoading()) {
    load();
  }

  final ExpenseRepository expensesRepository;

  void load() async {
    final result = await expensesRepository.fetch();

    if (result.isValue) {
      state = AsyncData(ExpensesListWithTotal(expenses: result.asValue!.value));
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
    ExpensesListNotifier, AsyncValue<ExpensesListWithTotal>>(
  (ref) => ExpensesListNotifier(
    expensesRepository: ref.read(expenseRepositoryMockProvider),
  ),
);

final expensesByDateProvider =
    Provider.autoDispose.family<ExpensesListWithTotal, DateTime>(
  (ref, dateTime) {
    final expenses = ref.watch(expensesListViewModelProvider);
    if (expenses.isLoading || expenses.hasError) {
      return ExpensesListWithTotal(expenses: []);
    }

    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final expensesByDate = expenses.value?.expenses.where((e) {
      final d = DateTime(e.createdAtDateTime.year, e.createdAtDateTime.month,
          e.createdAtDateTime.day);
      return d == date;
    }).toList();

    return ExpensesListWithTotal(expenses: expensesByDate ?? []);
  },
);
