import 'package:async/async.dart';
import 'package:expense_tracker/src/features/expenses/domain/category.dart';

abstract class CategoryRepository {
  Future<Result<List<Category>>> fetch();
}
