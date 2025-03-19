import 'package:expense_tracker/src/features/expenses/domain/category.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';
import 'package:expense_tracker/src/features/expenses/ui/calendar_view.dart';
import 'package:expense_tracker/src/features/expenses/ui/create_expense_view.dart';
import 'package:expense_tracker/src/features/expenses/ui/expenses_list_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ExpenseAdapter());

  await Hive.openBox<Expense>('expenses');

  runApp(ProviderScope(child: ProviderDemoApp()));
}

class ProviderDemoApp extends StatelessWidget {
  const ProviderDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense tracker'),
      ),
      body: Column(
        children: [
          CalendarView(),
          Expanded(
            child: ExpensesListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO navigate to create screen

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateExpenseView()),
          );
        },
      ),
    );
  }
}
