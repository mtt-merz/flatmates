import 'package:flatmates/app/models/expense.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen([this.expense, Key? key]) : super(key: key);

  final Expense? expense;

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    expense = widget.expense ??
        Expense.init(
          issuers: [UserRepository.instance.user.name!],
          addresses: ['test', 'test', 'test'],
        );
  }

  late Expense expense;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            shrinkWrap: true,
            children: [
              // SizedBox(width: MediaQuery.of(context).size.width),
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
                onChanged: (value) => expense.amount = double.parse(value),
              ),

              // Expense description
              const SizedBox(height: 12),
              TextFormField(
                style: Theme.of(context).textTheme.subtitle1,
                decoration: const InputDecoration(label: Text('Description')),
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) => expense.title = value,
              ),

              // Expense issuers
              const SizedBox(height: 16),
              Text('From', style: Theme.of(context).textTheme.subtitle2),
              Wrap(
                children: FlatRepository.instance.mainFlat.mates
                    .map((user) => ChoiceChip(
                          elevation: 0.0,
                          pressElevation: 0.0,
                          visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
                          label: Text(user.substring(0, 4)),
                          selected: expense.issuers.contains(user.substring(0, 4)),
                          onSelected: (value) => setState(() => value
                              ? expense.issuers.add(user)
                              : expense.issuers.remove(user)),
                        ))
                    .toList(),
              ),

              // Expense addresses
              const SizedBox(height: 12),
              Text('To', style: Theme.of(context).textTheme.subtitle2),
              Wrap(
                children: FlatRepository.instance.mainFlat.mates
                    .map((user) => ChoiceChip(
                          elevation: 0.0,
                          pressElevation: 0.0,
                          visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
                          label: Text(user.substring(0, 4)),
                          selected: expense.addresses.contains(user.substring(0, 4)),
                          onSelected: (value) => setState(() => value
                              ? expense.addresses.add(user)
                              : expense.addresses.remove(user)),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    child: const Text('Save'),
                    onPressed: () => Navigator.of(context).pop(expense),
                  )
                ],
              )
            ],
          ),
        ));
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
