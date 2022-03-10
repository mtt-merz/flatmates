import 'package:flutter/material.dart';

class CardColumn extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final Widget? action;
  final CrossAxisAlignment crossAxisAlignment;

  const CardColumn({
    Key? key,
    this.title,
    required this.children,
    this.action,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = [...this.children];
    if (title != null)
      children.insert(
          0,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title!, style: Theme.of(context).textTheme.labelMedium),
                action ?? const SizedBox(),
              ],
            ),
          ));

    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          )),
    );
  }
}
