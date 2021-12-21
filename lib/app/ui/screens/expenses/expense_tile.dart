import 'package:flatmates/app/ui/screens/user/user_avatar.dart';
import 'package:flatmates/app/models/expense.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;

  const ExpenseTile(this.expense, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(expense.title),
        subtitle: Text(expense.issuers.join(', ')),
        leading: UserAvatar(UserRepository.instance.user),
        trailing:
            Text('€ ${expense.amount}', style: Theme.of(context).textTheme.bodyText1),
        visualDensity: VisualDensity.compact,
        onTap: () => showDialog(context: context, builder: (context) => Dialog()),
      );
}
