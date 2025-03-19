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

  runApp(const ProviderScope(child: ProviderDemoApp()));
}

class ProviderDemoApp extends StatelessWidget {
  const ProviderDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeView(),
      theme: ThemeData(
        chipTheme: ChipThemeData(
          padding: EdgeInsets.zero,
          labelPadding: const EdgeInsets.all(2),
          labelStyle: Theme.of(context).textTheme.labelSmall,
        ),
      ),
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
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CalendarView()),
          ExpensesListView()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateExpenseView()),
          );
        },
      ),
    );
  }
}
