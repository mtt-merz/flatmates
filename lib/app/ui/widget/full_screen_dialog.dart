import 'package:flutter/material.dart';

class FullScreenDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget action;

  const FullScreenDialog({
    required this.title,
    required this.children,
    required this.action,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dialog(
        insetPadding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(title, style: Theme.of(context).textTheme.headline6),
                ],
              ),
            ),
            Expanded(
                child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shrinkWrap: true,
              children: children,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: action,
            )
          ],
        ),
      );
}
