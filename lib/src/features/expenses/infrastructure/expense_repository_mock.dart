import 'package:async/async.dart';
import 'package:expense_tracker/src/features/expenses/domain/category.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';
import 'package:expense_tracker/src/features/expenses/domain/expenses_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpenseRepositoryMock implements ExpenseRepository {
  @override
  Future<Result<List<Expense>>> fetch() {
    return Future(
      () => Result.value(
        [
          Expense(DateTime.now(), "apple", 200, Category(name: "fruits")),
          Expense(DateTime.now(), "apple", 200, Category(name: "fruits")),
          Expense(DateTime.now(), "apple", 200, Category(name: "fruits")),
          Expense(DateTime.now(), "apple", 200, Category(name: "fruits")),
          Expense(DateTime.now(), "apple", 200, Category(name: "fruits")),
          Expense(DateTime.now(), "apple", 200, Category(name: "fruits")),
          Expense(DateTime.now(), "apple", 200, Category(name: "food")),
          Expense(DateTime.now(), "apple", 200, Category(name: "food")),
          Expense(DateTime.now(), "apple", 200, Category(name: "food")),
          Expense(DateTime.now(), "apple", 200, Category(name: "food")),
          Expense(DateTime.now(), "apple", 200, Category(name: "food")),
          Expense(DateTime.now(), "apple", 200, Category(name: "food")),
        ],
      ),
    );
  }

  @override
  Future<Result<bool>> create(Expense expense) {
    return Future(() => Result.value(true));
  }
}

final expenseRepositoryMockProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepositoryMock();
});
