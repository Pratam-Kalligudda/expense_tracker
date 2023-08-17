import 'package:expense_app/expense_item.dart';
import 'package:expense_app/main.dart';
import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {required this.expenses, super.key, required this.onRemoveExpense});
  final void Function(Expense) onRemoveExpense;
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: ((ctx, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: EdgeInsets.all(16),
            ),
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]);
            },
            key: ValueKey(expenses[index]),
            child: ExpenseItem(expense: expenses[index]),
          )),
    );
  }
}
