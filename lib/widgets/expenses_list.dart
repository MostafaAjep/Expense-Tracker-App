import 'package:expenses_app/models/expense_model.dart';
import 'package:expenses_app/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expensesList,
      {super.key, required this.onRemoveExpense});

  final List<ExpenseModel> expensesList;
  final void Function(ExpenseModel expense)? onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        key: ValueKey(expensesList[index]),
        onDismissed: (direction) {
          onRemoveExpense!(expensesList[index]);
        },
        child: ExpenseItem(expensesList[index]),
      ),
      // Text(expensesList[index].title),
    );
  }
}
