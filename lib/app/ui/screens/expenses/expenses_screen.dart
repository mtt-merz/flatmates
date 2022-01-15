import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/ui/screens/expenses/add_expense_dialog.dart';
import 'package:flatmates/app/ui/screens/expenses/expense_tile.dart';
import 'package:flatmates/app/ui/utils/printer.dart';
import 'package:flatmates/app/ui/widget/page_template.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  // Widget buildBalanceWidget(List<Mate> mates) {
  //   const balance = -5.03;
  //   const color = balance >= 0 ? Colors.green : Colors.red;
  //
  //   return Column(
  //     children: [
  //       Card(
  //         child: ListView.separated(
  //           shrinkWrap: true,
  //           separatorBuilder: (c, i) => const Divider(),
  //           itemCount: mates.length,
  //           itemBuilder: (c, i) => ListTile(
  //             // leading: mates[i].avatar,
  //             title: Text(mates[i].name),
  //             trailing: Text('€ $balance',
  //                 style: Theme.of(context).textTheme.bodyText2!.copyWith(color: color)),
  //           ),
  //         ),
  //       ),
  //       ElevatedButton(onPressed: () {}, child: const Text('Solve balance')),
  //     ],
  //   );
  // }

  Widget buildExpensesDiaryWidget(List<List<Expense>> expensesDiary) {
    if (expensesDiary.isEmpty) return const Text('No expenses added');

    return Column(
      children: expensesDiary
          .map((List<Expense> dailyExpenses) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 32),
                    child: Text(Printer().dateVerbose(dailyExpenses.first.createdAt),
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  Card(
                    child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (c, i) => const Divider(),
                        itemCount: dailyExpenses.length,
                        itemBuilder: (c, i) => ExpenseTile(dailyExpenses[i])),
                  ),
                ],
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: const PageTemplate(
          title: 'Expenses',
          children: [
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
            Card(child: ListTile(title: Text(''))),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () =>
              showDialog(context: context, builder: (context) => const AddExpenseDialog()),
        ),
      );
}
