import 'package:flatmates/app/models/expense/expense.dart';
import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/ui/utils/printer.dart';
import 'package:flatmates/app/ui/utils/size.dart';
import 'package:flatmates/app/ui/widget/mate_chip.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatefulWidget {
  final Expense expense;
  final void Function() edit;
  final void Function() remove;

  final Mate Function(String) getMateFromId;

  const ExpenseTile(this.expense,
      {Key? key,
      required this.edit,
      required this.remove,
      required this.getMateFromId})
      : super(key: key);

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {
  bool collapsed = true;

  Expense get expense => widget.expense;

  Mate get issuer => widget.getMateFromId(expense.issuerId);

  List<Mate> get addresses => expense.addresseeIds
      .map((addresseeId) => widget.getMateFromId(addresseeId))
      .toList();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ListTile(
            title: Text(expense.description ?? 'New expense'),
            subtitle: Text('From ${issuer.nickname}',
                style: Theme.of(context).textTheme.caption),
            trailing: Text('€ ${expense.amount}',
                style: Theme.of(context).textTheme.bodyText1),
            visualDensity: VisualDensity.compact,
            onTap: () => setState(() => collapsed = !collapsed),
          ),

          // Content
          AnimatedSize(
            duration: const Duration(milliseconds: 100),
            child: Container(
                height: collapsed ? 0 : null,
                padding: SizeUtils.of(context).listPadding,
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(.4),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    buildFieldWidget(
                      icon: Icons.access_time,
                      field: Text(Printer.timeFromDate(expense.timestamp),
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                    // buildFieldWidget(
                    //   icon: Icons.account_circle_outlined,
                    //   field: MateChip(issuer),
                    // ),
                    buildFieldWidget(
                      icon: Icons.people,
                      field: Row(children: [
                        ...addresses.map((mate) => MateChip(mate))
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: widget.edit,
                          child: const Text('EDIT'),
                        ),
                        TextButton(
                            onPressed: widget.remove,
                            child: const Text('REMOVE')),
                      ],
                    ),
                  ],
                )),
          )
        ],
      );

  Widget buildFieldWidget({required IconData icon, required Widget field}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Icon(icon), field],
      );
}
