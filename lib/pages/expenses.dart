import 'package:expenses_app/models/expense_model.dart';
import 'package:expenses_app/widgets/chart/chart.dart';
import 'package:expenses_app/widgets/expenses_list.dart';
import 'package:expenses_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final List<ExpenseModel> entaredExpenses = [
    ExpenseModel(
      title: 'Flutter Course',
      amount: 20.993,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: 'Cinema',
      amount: 40.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void openExpensesPage() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: addExpense));
  }

  void addExpense(ExpenseModel expense) {
    setState(() {
      entaredExpenses.add(expense);
    });
  }

  void removeExpense(ExpenseModel expense) {
    final expenseIndex = entaredExpenses.indexOf(expense);
    setState(() {
      entaredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              entaredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
        content: const Text('Expense Deleted.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text(
        'No expenses found.Start adding some!',
      ),
    );
    if (entaredExpenses.isNotEmpty) {
      mainContent =
          ExpensesList(entaredExpenses, onRemoveExpense: removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expenses Tracker App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 79, 9, 92),
        actions: [
          IconButton(
            color: Colors.white,
            splashRadius: 22,
            tooltip: 'Add expense',
            icon: const Icon(
              Icons.add,
              size: 24,
            ),
            onPressed: openExpensesPage,
          ),
        ],
      ),
      body: width < 600
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chart(expenses: entaredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: entaredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
