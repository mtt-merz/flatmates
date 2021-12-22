import 'package:flatmates/app/models/user.dart';
import 'package:flatmates/app/ui/screens/expenses/expense_tile.dart';
import 'package:flatmates/app/ui/screens/expenses/expense_view_model.dart';
import 'package:flatmates/app/ui/utils/printer.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  Widget buildBalanceWidget(List<User> mates) {
    const balance = -5.03;
    const color = balance >= 0 ? Colors.green : Colors.red;

    return Column(
      children: [
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (c, i) => const Divider(),
            itemCount: mates.length,
            itemBuilder: (c, i) => ListTile(
              // leading: mates[i].avatar,
              title: Text(mates[i].name),
              trailing: Text('€ $balance',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: color)),
            ),
          ),
        ),
        ElevatedButton(onPressed: () {}, child: const Text('Solve balance')),
      ],
    );
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: ListView(
        children: [
          // Total balance of mates
          // buildBalanceWidget(mates),

          // Expenses history
          StreamBuilder(
              stream: ExpenseViewModel.expensesDiaryStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) return const CircularProgressIndicator();
                if (!snapshot.hasData) return const CircularProgressIndicator();

                List<List<Expense>> expensesDiary = snapshot.data as List<List<Expense>>;
                return buildExpensesDiaryWidget(expensesDiary);
              })
        ],
      ),
    );
  }
}
