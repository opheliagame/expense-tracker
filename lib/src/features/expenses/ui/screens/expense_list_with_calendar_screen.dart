import 'package:expense_tracker/src/components/hex_color.dart';
import 'package:expense_tracker/src/components/my_chip.dart';
import 'package:expense_tracker/src/features/app_bar/common_app_bar.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';
import 'package:expense_tracker/src/features/expenses/ui/expenses_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class ExpensesListWithCalendarScreen extends ConsumerWidget {
  const ExpensesListWithCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CalendarView()),
          FilterWidget(),
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

class FilterWidget extends ConsumerWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFiltering = ref.watch(isExpenseListMultiSelectionModeProvider);

    if (!isFiltering) return const SliverToBoxAdapter(child: SizedBox.shrink());

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                ref
                    .read(isExpenseListMultiSelectionModeProvider.notifier)
                    .state = !ref.read(isExpenseListMultiSelectionModeProvider);
              },
              icon: const Icon(Icons.close),
            ),
            const SizedBox(width: 12),
            Text('10 items selected'),
          ],
        ),
      ),
    );
  }
}

class CalendarView extends HookConsumerWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesListViewModelProvider);
    final calendarFormat = useState(CalendarFormat.month);
    final selectedDay = useState(DateTime.now());

    if (expenses.isLoading) {
      return const CircularProgressIndicator();
    }

    return TableCalendar(
      focusedDay: selectedDay.value,
      firstDay: DateTime(2024, 08, 01),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay.value, day);
      },
      onDaySelected: (newSelectedDay, focusedDay) {
        selectedDay.value = newSelectedDay;
      },
      calendarFormat: calendarFormat.value,
      onFormatChanged: (newCalendarFormat) {
        calendarFormat.value = newCalendarFormat;
      },
      onPageChanged: (focusedDay) {
        selectedDay.value = focusedDay;
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          final totalString =
              ref.watch(expensesByDateProvider(day)).totalString;

          if (totalString == '0') return null;
          return Text(
            totalString,
            style: Theme.of(context).textTheme.labelSmall,
          );
        },
      ),
    );
  }
}

class ExpensesListView extends ConsumerWidget {
  const ExpensesListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(expensesListViewModelProvider);

    return state.when(
      data: (data) {
        return SliverList.builder(
          itemBuilder: (context, index) {
            final expense = data.expenses[index];
            return ExpenseListTile(expense: expense);
          },
          itemCount: data.expenses.length,
        );
      },
      error: (error, stack) =>
          SliverToBoxAdapter(child: Text(error.toString())),
      loading: () =>
          const SliverToBoxAdapter(child: CircularProgressIndicator()),
    );
  }
}

class ExpenseListTile extends HookConsumerWidget {
  const ExpenseListTile({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = useState<bool>(false);
    final isShowCheckbox = ref.watch(isExpenseListMultiSelectionModeProvider);

    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: () {
        isChecked.value = !isChecked.value;
      },
      onLongPress: () {
        ref.read(isExpenseListMultiSelectionModeProvider.notifier).state = true;
      },
      child: ListTile(
        dense: true,
        leading: isShowCheckbox
            ? IconButton(
                onPressed: () {
                  isChecked.value = !isChecked.value;
                },
                icon: isChecked.value
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.check_box_outline_blank),
              )
            : null,
        title: Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Flexible(child: Text(expense.title, textAlign: TextAlign.left)),
            const SizedBox(width: 4),
            MyChip(
              label: expense.category.name,
              backgroundColor: HexColor.fromHex(expense.category.displayColor),
            ),
          ],
        ),
        trailing: Text(
          expense.amountString,
        ),
      ),
    );
  }
}

final isExpenseListMultiSelectionModeProvider = StateProvider<bool>((ref) {
  return false;
});
