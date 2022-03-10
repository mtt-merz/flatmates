import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/ui/utils/printer.dart';
import 'package:flatmates/app/ui/widget/page_template.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  Widget buildExpensesDiaryWidget(List<List<Expense>> expensesDiary) {
    if (expensesDiary.isEmpty) return const Text('No expenses added');

    return Column(
      children: expensesDiary
          .map((List<Expense> dailyExpenses) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 32),
                    child: Text(Printer().dateVerbose(dailyExpenses.first.timestamp),
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  Card(
                    child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (c, i) => const Divider(),
                        itemCount: dailyExpenses.length,
                        itemBuilder: (c, i) => buildExpenseTile(dailyExpenses[i])),
                  ),
                ],
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: PageTemplate(
          title: 'Expenses',
          children: [],
        ),
      );

  Widget buildExpenseTile(Expense expense) => ListTile(
        title: Text(expense.description ?? 'New expense'),
        subtitle: Text(expense.issuerId),
        trailing: Text('€ ${expense.amount}', style: Theme.of(context).textTheme.bodyText1),
        visualDensity: VisualDensity.compact,
        onTap: () => showDialog(context: context, builder: (context) => const Dialog()),
      );
}
