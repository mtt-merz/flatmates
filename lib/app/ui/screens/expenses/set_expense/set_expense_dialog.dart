import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flatmates/app/ui/widget/form_dialog.dart';
import 'package:flatmates/app/ui/widget/mate_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'set_expense_cubit.dart';

void showSetExpenseDialog(context,
        {Expense? expense, required void Function(Expense) onSuccess}) =>
    showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (context) => SetExpenseDialog(expense),
    ).then((result) => result == null ? null : onSuccess(result as Expense));

class SetExpenseDialog extends StatefulWidget {
  final Expense? expense;

  const SetExpenseDialog(this.expense, {Key? key}) : super(key: key);

  @override
  _SetExpenseDialogState createState() => _SetExpenseDialogState();
}

class _SetExpenseDialogState extends State<SetExpenseDialog> {
  late final cubit = SetExpenseCubit(widget.expense);

  late final amountController =
      TextEditingController(text: widget.expense?.amount.toString());
  late final descriptionController =
      TextEditingController(text: widget.expense?.description);

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
        bloc: cubit,
        builder: (context, SetExpenseState state) => FormDialog(
          title: widget.expense == null ? 'Add expense' : 'Expense',
          onCancel: Navigator.of(context).pop,
          onSubmit: cubit.canSubmit
              ? () => Navigator.of(context).pop(state.expense)
              : null,
          children: [
            // Expense amount
            FieldContainer(
              label: 'amount',
              isMandatory: true,
              child: TextFormField(
                controller: amountController,
                autofocus: widget.expense == null,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.black87),
                inputFormatters: [_ExpenseTextFormatter()],
                decoration:
                    const InputDecoration(hintText: '0', suffix: Text(' €')),
                textInputAction: TextInputAction.next,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                onChanged: cubit.setAmount,
              ),
            ),

            // Expense description
            FieldContainer(
              label: 'description',
              child: TextField(
                controller: descriptionController,
                style: Theme.of(context).textTheme.subtitle1,
                decoration: const InputDecoration(
                    label: Text('What is this expense for?')),
                textCapitalization: TextCapitalization.sentences,
                onChanged: cubit.setDescription,
              ),
            ),

            // Expense addresses
            FieldContainer(
              label: 'ADDRESSES',
              isMandatory: true,
              child: Wrap(
                spacing: 8,
                children: cubit.mates
                    .map((mate) => MateChip(mate,
                        onToggle: (value) => value
                            ? cubit.addAddressee(mate.userId)
                            : cubit.removeAddressee(mate.userId)))
                    .toList(),
              ),
            ),
          ],
        ),
      );
}

class _ExpenseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    TextEditingValue buildTextEditingValue(String text) => TextEditingValue(
          text: text,
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
        );

    if (newValue.text.isEmpty) return buildTextEditingValue('');
    if (oldValue.text.isEmpty && newValue.text == '.')
      return buildTextEditingValue('0.');

    try {
      double.parse(newValue.text);
    } on Object {
      return buildTextEditingValue(oldValue.text);
    }

    if (newValue.text.contains('.')) {
      final parts = newValue.text.split('.');
      if (parts.last.length > 2) parts.last = parts.last.substring(0, 2);
      return buildTextEditingValue(parts.join('.'));
    }

    return buildTextEditingValue(newValue.text);
  }
}
