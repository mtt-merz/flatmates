import 'package:flatmates/app/ui/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CardEmphasis extends StatelessWidget {
  final Image image;
  final String title;
  final String subtitle;
  final void Function() onTap;

  const CardEmphasis({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Card(
          color: Theme.of(context).colorScheme.secondary,
          child: Stack(
            children: [
              Positioned(
                left: -SizeUtils.of(context).getScaledWidth(5),
                width: SizeUtils.of(context).getScaledWidth(45),
                child: image,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 24)
                    .add(EdgeInsets.only(left: SizeUtils.of(context).getScaledWidth(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(title,
                        textAlign: TextAlign.end,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Theme.of(context).colorScheme.onSecondary)),
                    const SizedBox(height: 9),
                    Text(subtitle,
                        textAlign: TextAlign.end,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Theme.of(context).colorScheme.onSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
