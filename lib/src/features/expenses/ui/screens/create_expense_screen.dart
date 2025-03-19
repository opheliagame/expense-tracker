import 'package:expense_tracker/src/features/app_bar/common_app_bar.dart';
import 'package:expense_tracker/src/features/expenses/domain/category.dart';
import 'package:expense_tracker/src/features/expenses/domain/expense.dart';
import 'package:expense_tracker/src/features/expenses/ui/category_list_notifier.dart';
import 'package:expense_tracker/src/features/expenses/ui/expenses_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateExpenseScreen extends HookConsumerWidget {
  const CreateExpenseScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(expensesListViewModelProvider.notifier);
    final categories = ref.read(categoriesProvider);

    final titleTextFieldController = useTextEditingController();
    final amountTextFieldController = useTextEditingController();
    final category = useState<Category>(Category(name: "food"));

    return Scaffold(
      appBar: const CommonAppBar(),
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
              categories.when(
                data: (data) {
                  return DropdownButtonFormField<Category>(
                    items: data
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    onChanged: (newValue) {
                      if (newValue == null) return;
                      category.value = newValue;
                    },
                  );
                },
                error: (error, stack) => Container(),
                loading: () => const CircularProgressIndicator(),
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
                child: const Text('submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
