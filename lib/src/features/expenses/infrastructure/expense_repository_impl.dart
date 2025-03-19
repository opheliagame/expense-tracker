import 'package:async/async.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';
import 'package:expense_tracker/src/features/expenses/domain/expenses_repository.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class ExpensesRepositoryImpl implements ExpenseRepository {
  static final box = Hive.box<Expense>('expenses');

  @override
  Future<Result<List<Expense>>> fetch() async {
    try {
      return Result.value(box.values.toList());
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> create(Expense expense) async {
    try {
      box.put(const Uuid().v4(), expense);

      return Result.value(true);
    } catch (e) {
      return Result.error(e);
    }
  }
}

final expensesRepositoryProvider =
    Provider<ExpenseRepository>((ref) => ExpensesRepositoryImpl());
