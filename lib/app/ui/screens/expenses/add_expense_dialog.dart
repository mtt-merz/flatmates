import 'package:flatmates/app/ui/screens/expenses/expense_view_model.dart';
import 'package:flatmates/app/ui/widget/full_screen_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpenseDialog extends StatefulWidget {
  const AddExpenseDialog({Key? key}) : super(key: key);

  @override
  _AddExpenseDialogState createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final Expense expense = ExpenseViewModel.defaultExpense;

  @override
  Widget build(BuildContext context) => FullScreenDialog(
        title: 'Add expense',
        children: [
          // Expense amount
          TextFormField(
            autofocus: true,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.headline2,
            inputFormatters: [_ExpenseTextFormatter()],
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '0.00',
              suffix: Text(' €'),
            ),
            textInputAction: TextInputAction.next,
            keyboardType:
                const TextInputType.numberWithOptions(signed: false, decimal: false),
            onChanged: (value) => setState(() => expense.amount = double.parse(value)),
          ),

          // Expense description
          const SizedBox(height: 12),
          TextFormField(
            style: Theme.of(context).textTheme.subtitle1,
            decoration: const InputDecoration(label: Text('Description')),
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) => setState(() => expense.description = value),
          ),

          // Expense issuers
          const SizedBox(height: 16),
          Text('From', style: Theme.of(context).textTheme.subtitle2),
          Wrap(
            children: ExpenseViewModel.mates
                .map((user) => ChoiceChip(
                      elevation: 0.0,
                      pressElevation: 0.0,
                      visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
                      label: Text(user.name),
                      selected: expense.issuers.contains(user.id),
                      onSelected: (value) => setState(() => value
                          ? expense.issuers.add(user.id)
                          : expense.issuers.remove(user.id)),
                    ))
                .toList(),
          ),

          // Expense addresses
          const SizedBox(height: 12),
          Text('To', style: Theme.of(context).textTheme.subtitle2),
          Wrap(
            children: ExpenseViewModel.mates
                .map((user) => ChoiceChip(
                      elevation: 0.0,
                      pressElevation: 0.0,
                      visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
                      label: Text(user.name),
                      selected: expense.addresses.contains(user.id),
                      onSelected: (value) => setState(() => value
                          ? expense.addresses.add(user.id)
                          : expense.addresses.remove(user.id)),
                    ))
                .toList(),
          ),
        ],
        action: ElevatedButton(
          child: const Text('Save'),
          onPressed: ExpenseViewModel.check(expense) ? submit : null,
        ),
      );

  submit() {
    ExpenseViewModel.insert(expense);
    Navigator.of(context).pop();
  }
}

class _ExpenseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String edited = oldValue.text;

    final newChar = newValue.text.characters.last;
    if (int.tryParse(newChar) != null) {
      edited = newValue.text.split('.').join();
      while (edited.length < 3) edited = '0$edited';

      edited = [edited.characters.take(edited.length - 2), edited.characters.takeLast(2)]
          .join('.');

      while (edited.startsWith('0') && edited.length > 4)
        edited = edited.substring(1, edited.length);
    }

    return TextEditingValue(
      text: edited,
      selection: TextSelection(
        baseOffset: edited.length,
        extentOffset: edited.length,
      ),
    );
  }
}
