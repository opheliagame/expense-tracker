import 'package:expense_tracker/src/features/expenses/ui/expenses_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesListView extends ConsumerWidget {
  const ExpensesListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(expensesListViewModelProvider);

    return state.when(
      data: (data) {
        return Column(
          children: [
            Text('Expenses List'),
            Expanded(
              // child: ListView.builder(
              //   itemCount: data.length,
              //   itemBuilder: (context, index) {
              //     final item = data[index];

              //     return Text(item.title);
              //   },
              // ),

              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text('title'),
                  ),
                  DataColumn(
                    label: Text('amount'),
                  ),
                  DataColumn(
                    label: Text('category'),
                  ),
                ],
                rows: data
                    .map((e) => DataRow(cells: [
                          DataCell(Text(e.title)),
                          DataCell(Text(e.amount.toString())),
                          DataCell(Text(e.category)),
                        ]))
                    .toList(),
              ),
            ),
          ],
        );
      },
      error: (error, stack) => Text(error.toString()),
      loading: () => CircularProgressIndicator(),
    );
  }
}
