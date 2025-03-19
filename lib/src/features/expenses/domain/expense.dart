import 'package:expense_tracker/src/features/expenses/domain/category.dart';
import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 1)
class Expense {
  @HiveField(0)
  DateTime dateTime;
  @HiveField(1)
  String title;
  @HiveField(2)
  double amount;
  @HiveField(3)
  Category category;

  Expense(this.dateTime, this.title, this.amount, this.category);

  @override
  String toString() {
    return '$dateTime $title $amount ${category.name}';
  }
}
