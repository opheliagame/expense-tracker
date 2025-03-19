import 'package:async/async.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';
import 'package:expense_tracker/src/features/expenses/domain/expenses_repository.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class ExpensesRepositoryImpl implements ExpensesRepository {
  static final box = Hive.box<Expense>('expenses');

  @override
  Future<Result<List<Expense>>> fetch() async {
    try {
      return Result.value(box.values.toList());
    } catch (e) {
      return Result.error(e);
    }
  }

// TODO check if async even required here
  @override
  Future<Result<bool>> create(Expense expense) async {
    try {
      // TODO change ID of new item
      box.put(Uuid().v4(), expense);

      return Result.value(true);
    } catch (e) {
      return Result.error(e);
    }
  }
}

final expensesRepositoryProvider =
    Provider<ExpensesRepository>((ref) => ExpensesRepositoryImpl());
