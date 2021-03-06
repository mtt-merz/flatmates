import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flatmates/app/ui/widget/form_dialog.dart';
import 'package:flatmates/app/ui/widget/mate_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_expense_cubit.dart';

class AddExpenseDialog extends StatefulWidget {
  const AddExpenseDialog({Key? key}) : super(key: key);

  @override
  _AddExpenseDialogState createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final cubit = AddExpenseCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if (state is! Editing)
          return const Center(child: CircularProgressIndicator());

        return FormDialog(
          title: 'Add expense',
          onCancel: Navigator.of(context).pop,
          onSubmit: cubit.canSubmit
              ? () {
                  cubit.submit();
                  Navigator.of(context).pop();
                }
              : null,
          children: [
            // Expense amount
            FieldContainer(
              label: 'amount',
              child: TextFormField(
                autofocus: true,
                style: Theme.of(context).textTheme.headline2,
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
        );
      });
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
