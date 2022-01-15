import 'package:flatmates/app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';

class CommonSpaceWidget extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final ImageProvider? image;

  const CommonSpaceWidget({
    Key? key,
    required this.title,
    required this.backgroundColor,
    this.image,
  }) : super(key: key);

  Color get contentColor => ColorUtils(backgroundColor).textColor;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: backgroundColor),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          color: backgroundColor,
          child: ListTile(
            leading:
                image != null ? SizedBox(width: MediaQuery.of(context).size.width * .25) : null,
            title: Text(title,
                style: Theme.of(context).textTheme.headline6!.copyWith(color: contentColor)),
          ),
        ),
      );
}
