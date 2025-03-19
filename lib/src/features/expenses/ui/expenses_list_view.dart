import 'package:expense_tracker/src/components/hex_color.dart';
import 'package:expense_tracker/src/components/my_chip.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';
import 'package:expense_tracker/src/features/expenses/ui/expenses_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExpensesListView extends ConsumerWidget {
  const ExpensesListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(expensesListViewModelProvider);

    return state.when(
      data: (data) {
        return SliverList.builder(
          itemBuilder: (context, index) {
            final expense = data[index];
            return ExpenseListTile(expense: expense);
          },
          itemCount: data.length,
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
    final expensesNotifier = ref.watch(expensesListViewModelProvider.notifier);

    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: () {
        isChecked.value = !isChecked.value;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              isChecked.value = !isChecked.value;
            },
            icon: isChecked.value
                ? const Icon(Icons.check_box)
                : const Icon(Icons.check_box_outline_blank),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(expense.title, textAlign: TextAlign.left),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    expensesNotifier.filterByCategory(expense.category);
                  },
                  child: MyChip(
                    label: expense.category.name,
                    backgroundColor:
                        HexColor.fromHex(expense.category.displayColor),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(expense.amount.toString()),
          ),
        ],
      ),
    );
  }
}
