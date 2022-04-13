import 'package:flutter/material.dart';

class FieldContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final String? label;
  final String? description;

  const FieldContainer({
    Key? key,
    required this.child,
    this.label,
    this.description,
    this.padding = const EdgeInsets.only(bottom: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 2, bottom: 5),
                  child: Text(label!.toUpperCase(), style: Theme.of(context).textTheme.labelMedium),
                ),
          child,
          description == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 2, top: 6),
                  child: Text(description!, style: Theme.of(context).textTheme.bodySmall),
                ),
        ],
      ));
}
