import 'package:flutter/material.dart';

class DialogTemplate extends StatelessWidget {
  final String title;
  final List<Widget> children;

  final void Function()? onSubmit;
  final void Function()? onCancel;

  const DialogTemplate({
    required this.title,
    required this.children,
    required this.onSubmit,
    this.onCancel,
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
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  onCancel != null
                      ? TextButton(onPressed: onCancel!, child: const Text('Cancel'))
                      : const SizedBox(),
                  const SizedBox(width: 10),
                  ElevatedButton(onPressed: onSubmit, child: const Text('Save'))
                ],
              ),
            )
          ],
        ),
      );
}
