import 'package:flatmates/app/ui/screens/expenses/expense_view_model.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;

  const ExpenseTile(this.expense, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(expense.description ?? 'New expense'),
        subtitle: Text(expense.issuers
            .map((mateId) => ExpenseViewModel.getMate(mateId).name)
            .join(', ')),
        leading: CircleAvatar(
            child: Text(
                ExpenseViewModel.getMate(expense.issuers.first).name.characters.first)),
        trailing:
            Text('€ ${expense.amount}', style: Theme.of(context).textTheme.bodyText1),
        visualDensity: VisualDensity.compact,
        onTap: () => showDialog(context: context, builder: (context) => const Dialog()),
      );
}
