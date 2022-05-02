import 'package:flutter/material.dart';

class FieldContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final String? label;
  final String? description;
  final bool isMandatory;

  const FieldContainer({
    Key? key,
    required this.child,
    this.label,
    this.description,
    this.isMandatory = false,
    this.padding = const EdgeInsets.only(bottom: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabelWidget(context),
          child,
          description == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 2, top: 6),
                  child: Text(description!,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
        ],
      ));

  Widget buildLabelWidget(BuildContext context) {
    if (label == null) return const SizedBox();

    String text = isMandatory ? '${label!}*' : label!;
    return Padding(
      padding: const EdgeInsets.only(left: 2, bottom: 5),
      child: Text(text.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium),
    );
  }
}
