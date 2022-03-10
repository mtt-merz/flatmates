import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/ui/widget/field_container.dart';
import 'package:flatmates/app/ui/widget/form_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'expense_adder_cubit.dart';

class ExpenseAdderDialog extends StatefulWidget {
  const ExpenseAdderDialog({Key? key}) : super(key: key);

  @override
  _ExpenseAdderDialogState createState() => _ExpenseAdderDialogState();
}

class _ExpenseAdderDialogState extends State<ExpenseAdderDialog> {
  final cubit = GetIt.I<ExpenseAdderCubit>();

  @override
  Widget build(BuildContext context) => BlocBuilder(
      bloc: cubit,
      builder: (context, Expense? expense) {
        if (expense == null) return const Center(child: CircularProgressIndicator());

        return FormDialog(
          title: 'Add expense',
          children: [
            // Expense amount
            FieldContainer(
              label: 'AMOUNT',
              child: TextFormField(
                autofocus: true,
                style: Theme.of(context).textTheme.headline2,
                inputFormatters: [_ExpenseTextFormatter()],
                decoration: const InputDecoration(hintText: '0', suffix: Text(' €')),
                textInputAction: TextInputAction.next,
                keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                onChanged: (value) => setState(() => cubit.expenseAmount = double.parse(value)),
              ),
            ),

            // Expense description
            FieldContainer(
              label: 'DESCRIPTION',
              child: TextField(
                style: Theme.of(context).textTheme.subtitle1,
                decoration: const InputDecoration(label: Text('What is this expense for?')),
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) => setState(() => cubit.expenseDescription = value),
              ),
            ),

            // Expense addresses
            FieldContainer(
              label: 'ADDRESSES',
              child: Wrap(
                children: cubit.mates
                    .map((mate) => ChoiceChip(
                          elevation: 0.0,
                          pressElevation: 0.0,
                          visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
                          label: Text(mate.name),
                          selected: expense.addresseeIds.any((mateName) => mateName == mate.name),
                          onSelected: (value) =>
                              value ? cubit.addAddressee('test') : cubit.addAddressee(mate.name),
                        ))
                    .toList(),
              ),
            ),
          ],
          onSubmit: cubit.canSubmit ? () => Navigator.of(context).pop(expense) : null,
          onCancel: Navigator.of(context).pop,
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
          selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
        );

    if (newValue.text.isEmpty) return buildTextEditingValue('');
    if (oldValue.text.isEmpty && newValue.text == '.') return buildTextEditingValue('0.');

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
