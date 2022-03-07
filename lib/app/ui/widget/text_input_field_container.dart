import 'package:flutter/material.dart';

class TextInputFieldContainer extends StatelessWidget {
  final TextField field;
  final EdgeInsets padding;
  final String? label;

  const TextInputFieldContainer({
    Key? key,
    required this.field,
    this.label,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelWidget = label == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(left: 7, bottom: 4),
            child: Text(label!, style: Theme.of(context).textTheme.labelMedium),
          );

    return Padding(
      padding: padding,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [labelWidget, field]),
    );
  }
}
