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
          Expense(
              createdAt: "2025-03-01T08:30:00.000Z",
              title: "Bananas",
              amount: 150,
              category: Category(name: "fruits")),
          Expense(
              createdAt: "2025-03-02T12:45:00.000Z",
              title: "Coffee",
              amount: 300,
              category: Category(name: "beverages")),
          Expense(
              createdAt: "2025-03-03T19:20:00.000Z",
              title: "Lunch at Cafe",
              amount: 1200,
              category: Category(name: "food")),
          Expense(
              createdAt: "2025-03-04T15:10:00.000Z",
              title: "Notebook",
              amount: 250,
              category: Category(name: "stationery")),
          Expense(
              createdAt: "2025-03-05T21:30:00.000Z",
              title: "Movie Ticket",
              amount: 500,
              category: Category(name: "entertainment")),
          Expense(
              createdAt: "2025-03-06T10:00:00.000Z",
              title: "Bus Ticket",
              amount: 100,
              category: Category(name: "transportation")),
          Expense(
              createdAt: "2025-03-07T14:15:00.000Z",
              title: "Grapes",
              amount: 200,
              category: Category(name: "fruits")),
          Expense(
              createdAt: "2025-03-08T18:45:00.000Z",
              title: "Dinner",
              amount: 1500,
              category: Category(name: "food")),
          Expense(
              createdAt: "2025-03-09T09:00:00.000Z",
              title: "Milk",
              amount: 180,
              category: Category(name: "groceries")),
          Expense(
              createdAt: "2025-03-10T16:30:00.000Z",
              title: "Book",
              amount: 600,
              category: Category(name: "education")),
          Expense(
              createdAt: "2025-03-11T20:00:00.000Z",
              title: "Concert Ticket",
              amount: 2500,
              category: Category(name: "entertainment")),
          Expense(
              createdAt: "2025-03-12T07:45:00.000Z",
              title: "Gym Membership",
              amount: 3000,
              category: Category(name: "fitness")),
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
