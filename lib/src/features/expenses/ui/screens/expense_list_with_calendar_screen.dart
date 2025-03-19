import 'package:expense_tracker/src/features/app_bar/common_app_bar.dart';
import 'package:expense_tracker/src/features/expenses/ui/calendar_view.dart';
import 'package:expense_tracker/src/features/expenses/ui/expenses_list_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExpensesListWithCalendarScreen extends StatelessWidget {
  const ExpensesListWithCalendarScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CalendarView()),
          ExpensesListView()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
