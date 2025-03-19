import 'package:async/async.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';

abstract class ExpenseRepository {
  Future<Result<List<Expense>>> fetch();

  Future<Result<bool>> create(Expense expense);
}
