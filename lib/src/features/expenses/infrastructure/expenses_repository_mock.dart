import 'package:async/src/result/result.dart';
import 'package:expense_tracker/src/features/expenses/domain/category.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';
import 'package:expense_tracker/src/features/expenses/domain/expenses_repository.dart';

class ExpensesRepositoryMock implements ExpensesRepository {
  @override
  Future<Result<List<Expense>>> fetch() {
    return Future(
      () => Result.value(
        [
          Expense(DateTime.now(), "apple", 200, Category("fruits")),
          Expense(DateTime.now(), "apple", 200, Category("fruits")),
          Expense(DateTime.now(), "apple", 200, Category("fruits")),
          Expense(DateTime.now(), "apple", 200, Category("fruits")),
          Expense(DateTime.now(), "apple", 200, Category("fruits")),
          Expense(DateTime.now(), "apple", 200, Category("fruits")),
        ],
      ),
    );
  }

  @override
  Future<Result<bool>> create(Expense expense) {
    return Future(() => Result.value(true));
  }
}
