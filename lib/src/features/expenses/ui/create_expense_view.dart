import 'package:expense_tracker/src/features/expenses/domain/category.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';
import 'package:expense_tracker/src/features/expenses/ui/expenses_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateExpenseView extends HookConsumerWidget {
  const CreateExpenseView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(expensesListViewModelProvider.notifier);

    final titleTextFieldController = useTextEditingController();
    final amountTextFieldController = useTextEditingController();
    final category = useState<Category>(Category("food"));

    // TODO change later into class
    const categories = ['food', 'travel'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense tracker'),
      ),
      body: SafeArea(
        child: Form(
          child: Column(
            children: [
              TextField(
                controller: titleTextFieldController,
              ),
              TextField(
                controller: amountTextFieldController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              DropdownButtonFormField(
                items: categories
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  category.value = newValue ?? '';
                },
              ),
              ElevatedButton(
                onPressed: () {
                  final newExpense = Expense(
                    DateTime.now(),
                    titleTextFieldController.value.text,
                    double.tryParse(amountTextFieldController.value.text) ??
                        double.minPositive,
                    category.value,
                  );

                  viewModel.create(newExpense);
                },
                child: Text('submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
