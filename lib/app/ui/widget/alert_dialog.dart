import 'package:flatmates/app/ui/models/button.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    this.title,
    required this.content,
    required this.primaryButton,
    this.secondaryButton,
  }) : super(key: key);

  final String? title;
  final String content;
  final Button primaryButton;
  final Button? secondaryButton;

  List<Widget> get _actions {
    List<Widget> out = [];

    if (secondaryButton != null)
      out.add(OutlinedButton(
        child: secondaryButton!.child,
        onPressed: secondaryButton!.onPressed,
      ));

    out.add(ElevatedButton(
      child: primaryButton.child,
      onPressed: primaryButton.onPressed,
    ));

    return out;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!, textAlign: TextAlign.center) : null,
      content: Text(content, textAlign: TextAlign.center),
      actions: _actions,
      actionsAlignment: MainAxisAlignment.center,
      // elevation: 0.0,
    );
  }
}
