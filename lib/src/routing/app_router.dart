import 'package:expense_tracker/src/features/expenses/ui/screens/create_expense_screen.dart';
import 'package:expense_tracker/src/features/expenses/ui/screens/expense_list_with_calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ExpensesListWithCalendarScreen();
      },
      routes: [
        GoRoute(
          path: 'create',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateExpenseScreen();
          },
        ),
      ],
    ),
  ],
);
