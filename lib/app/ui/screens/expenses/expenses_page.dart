import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/ui/screens/expenses/expenses_cubit.dart';
import 'package:flatmates/app/ui/utils/printer.dart';
import 'package:flatmates/app/ui/utils/size.dart';
import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flatmates/app/ui/widget/page_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final ExpensesCubit cubit = ExpensesCubit();

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if (state is Loading)
          return const Center(child: CircularProgressIndicator());

        final expensesDiary = (state as Loaded).expensesDiary;

        return PageTemplate(
          title: 'Expenses',
          onRefresh: cubit.refresh,
          children: [
            // Mates balances
            Card(
                child: Column(
              children: cubit.mates.map((mate) {
                final balance = state.getMateBalance(mate.userId);
                return ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.circle,
                          size: 11, color: Color(mate.colorValue)),
                      const SizedBox(width: 8),
                      Text(mate.nickname,
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                  visualDensity: VisualDensity.compact,
                  trailing: Text('€ $balance',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: balance < 0 ? Colors.red : Colors.green)),
                );
              }).toList(),
            )),

            SizedBox(height: SizeUtils.of(context).getScaledHeight(4)),

            // Expenses
            expensesDiary.isEmpty
                ? const Text('There are no expenses right now',
                    textAlign: TextAlign.center)
                : Column(
                    children: expensesDiary
                        .map((dailyExpenses) => FieldContainer(
                              label: Printer.dateVerbose(
                                  dailyExpenses.first.timestamp),
                              child: Card(
                                child: Column(
                                    children: dailyExpenses
                                        .map((expense) => ExpenseTile(expense,
                                            getMateNicknameFromId:
                                                cubit.getMateNicknameFromId))
                                        .toList()),
                              ),
                            ))
                        .toList())
          ],
        );
      });
}

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final String Function(String) getMateNicknameFromId;

  const ExpenseTile(this.expense,
      {Key? key, required this.getMateNicknameFromId})
      : super(key: key);

  String get issuer => getMateNicknameFromId(expense.issuerId);

  String get addresses {
    final addresseeNames = expense.addresseeIds
        .map((addresseeId) => getMateNicknameFromId(addresseeId));

    return addresseeNames.join(', ');
  }

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(expense.description ?? 'New expense'),
        subtitle: Text('$issuer - $addresses'),
        trailing: Text('€ ${expense.amount}',
            style: Theme.of(context).textTheme.bodyText1),
        visualDensity: VisualDensity.compact,
        onTap: () =>
            showDialog(context: context, builder: (context) => const Dialog()),
      );
}