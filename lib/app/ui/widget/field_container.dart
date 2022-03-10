import 'package:flutter/material.dart';

class FieldContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final String? label;

  const FieldContainer({
    Key? key,
    required this.child,
    this.label,
    this.padding = const EdgeInsets.only(bottom: 24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelWidget = label == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 6),
            child: Text(label!.toUpperCase(), style: Theme.of(context).textTheme.labelMedium),
          );

    return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [labelWidget, child],
        ));
  }
}
