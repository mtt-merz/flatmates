import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flutter/material.dart';

import 'package:flatmates/app/ui/utils/color_utils.dart';

class MateChip extends StatefulWidget {
  final Mate mate;
  final bool initiallySelected;
  final void Function(bool)? onToggle;

  const MateChip(
    this.mate, {
    Key? key,
    this.initiallySelected = true,
    this.onToggle,
  }) : super(key: key);

  @override
  State<MateChip> createState() => _MateChipState();
}

class _MateChipState extends State<MateChip> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.initiallySelected;
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: widget.onToggle == null
            ? null
            : () {
                setState(() => _isSelected = !_isSelected);
                widget.onToggle!(_isSelected);
              },
        child: Opacity(
          opacity: _isSelected ? 1 : .4,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 13),
            decoration: BoxDecoration(
              color: Color(widget.mate.colorValue),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(widget.mate.name,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color:
                        ColorUtils(Color(widget.mate.colorValue)).textColor)),
          ),
        ),
      );
}
