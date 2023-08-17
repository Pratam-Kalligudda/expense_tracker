import 'package:expense_app/chart.dart';
import 'package:expense_app/chart_bar.dart';
import 'package:expense_app/expenses_list.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerdexpenses = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Cinema",
      amount: 14.63,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  void _addExpense(Expense expenses) {
    setState(() {
      _registerdexpenses.add(expenses);
    });
  }

  void _removeExpense(Expense expenses) {
    final expenseIndex = _registerdexpenses.indexOf(expenses);
    setState(() {
      _registerdexpenses.remove(expenses);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registerdexpenses.insert(expenseIndex, expenses);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    print(width);
    print(height);
    Widget mainContent = const Center(
      child: Text("No Expense Added!"),
    );

    if (_registerdexpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerdexpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Expense Tracker"), actions: [
        IconButton(
            onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
      ]),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registerdexpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registerdexpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
