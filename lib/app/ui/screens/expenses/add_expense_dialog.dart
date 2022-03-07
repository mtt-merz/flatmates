// import 'package:flatmates/app/models/expense/expense.dart';
// import 'package:flatmates/app/ui/screens/expenses/add_expense_cubit.dart';
// import 'package:flatmates/app/ui/widget/dialog_template.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class AddExpenseDialog extends StatefulWidget {
//   const AddExpenseDialog({Key? key}) : super(key: key);
//
//   @override
//   _AddExpenseDialogState createState() => _AddExpenseDialogState();
// }
//
// class _AddExpenseDialogState extends State<AddExpenseDialog> {
//   final AddExpenseCubit cubit = AddExpenseCubit();
//
//   @override
//   Widget build(BuildContext context) => BlocBuilder(
//       bloc: cubit,
//       builder: (context, state) {
//         if (state == null) return const Center(child: CircularProgressIndicator());
//
//         final expense = state as Expense;
//         return DialogTemplate(
//           title: 'Add expense',
//           children: [
//             // Expense amount
//             TextFormField(
//               autofocus: true,
//               textAlign: TextAlign.end,
//               style: Theme.of(context).textTheme.headline2,
//               inputFormatters: [_ExpenseTextFormatter()],
//               decoration: const InputDecoration(
//                 border: InputBorder.none,
//                 hintText: '0.00',
//                 suffix: Text(' €'),
//               ),
//               textInputAction: TextInputAction.next,
//               keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
//               onChanged: (value) => setState(() => cubit.expenseAmount = double.parse(value)),
//             ),
//
//             // Expense description
//             const SizedBox(height: 12),
//             TextFormField(
//               style: Theme.of(context).textTheme.subtitle1,
//               decoration: const InputDecoration(label: Text('Description')),
//               textCapitalization: TextCapitalization.sentences,
//               onChanged: (value) => setState(() => cubit.expenseDescription = value),
//             ),
//
//             // Expense issuers
//             // const SizedBox(height: 16),
//             // Text('From', style: Theme.of(context).textTheme.subtitle2),
//             // Wrap(
//             //   children: vm.mates
//             //       .map((user) => ChoiceChip(
//             //             elevation: 0.0,
//             //             pressElevation: 0.0,
//             //             visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
//             //             label: Text(user.name),
//             //             selected: expense.issuers.contains(user.id),
//             //             onSelected: (value) => setState(() =>
//             //                 value ? expense.issuers.add(user.id) : expense.issuers.remove(user.id)),
//             //           ))
//             //       .toList(),
//             // ),
//
//             // Expense addresses
//             const SizedBox(height: 12),
//             Text('To', style: Theme.of(context).textTheme.subtitle2),
//             Wrap(
//               children: cubit.mates
//                   .map((mate) => ChoiceChip(
//                         elevation: 0.0,
//                         pressElevation: 0.0,
//                         visualDensity: const VisualDensity(horizontal: 4, vertical: 4),
//                         label: Text(mate.name),
//                         selected: expense.addresseeIds.any((mateId) => mateId == mate.id),
//                         onSelected: (value) =>
//                             value ? cubit.addAddressee('test') : cubit.addAddressee(mate.id),
//                       ))
//                   .toList(),
//             ),
//           ],
//           onSubmit: cubit.canSubmit ? () => Navigator.of(context).pop(expense) : null,
//           onCancel: Navigator.of(context).pop,
//         );
//       });
// }
//
// class _ExpenseTextFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     String edited = oldValue.text;
//
//     final newChar = newValue.text.characters.last;
//     if (int.tryParse(newChar) != null) {
//       edited = newValue.text.split('.').join();
//       while (edited.length < 3) edited = '0$edited';
//
//       edited = [edited.characters.take(edited.length - 2), edited.characters.takeLast(2)].join('.');
//
//       while (edited.startsWith('0') && edited.length > 4)
//         edited = edited.substring(1, edited.length);
//     }
//
//     return TextEditingValue(
//       text: edited,
//       selection: TextSelection(
//         baseOffset: edited.length,
//         extentOffset: edited.length,
//       ),
//     );
//   }
// }
