import 'package:expense_tracker/src/features/expenses/domain/category.dart';
import 'package:expense_tracker/src/utils/formatters.dart';
import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 1)
class Expense {
  // Iso8601 String
  @HiveField(0)
  String createdAt;
  @HiveField(1)
  String title;
  @HiveField(2)
  double amount;
  @HiveField(3)
  Category category;

  Expense({
    required this.createdAt,
    required this.title,
    required this.amount,
    required this.category,
  });

  DateTime get createdAtDateTime => DateTime.parse(createdAt);

  String get amountString => currencyFormatter.format(amount);

  @override
  String toString() {
    return '$createdAt $title $amount ${category.name}';
  }
}

class ExpensesListWithTotal {
  final List<Expense> expenses;

  ExpensesListWithTotal({required this.expenses});

  double get total =>
      expenses.map((e) => e.amount).fold(0, (prev, element) => prev + element);

  String get totalString => compactCurrencyFormatter.format(total);
}
