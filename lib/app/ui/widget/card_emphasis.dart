import 'package:flutter/material.dart';

class CardEmphasis extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function() onTap;

  const CardEmphasis({Key? key, required this.title, required this.subtitle, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Card(
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Theme.of(context).colorScheme.onSecondary)),
                const SizedBox(height: 9),
                Text(subtitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Theme.of(context).colorScheme.onSecondary)),
              ],
            ),
          ),
        ),
      );
}
