import 'package:flatmates/app/ui/utils/size.dart';
import 'package:flatmates/app/ui/widget/submit_button.dart';
import 'package:flutter/material.dart';

class FormDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;

  final void Function()? onSubmit;
  final void Function()? onCancel;

  const FormDialog({
    required this.title,
    required this.children,
    required this.onSubmit,
    this.onCancel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              //Header
              Padding(
                padding: SizeUtils.of(context).basePadding.add(EdgeInsets.only(
                    top: SizeUtils.of(context).horizontalPaddingValue,
                    bottom: SizeUtils.of(context).horizontalPaddingValue / 2)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.headline5),
                    InkWell(child: const Icon(Icons.close), onTap: onCancel)
                  ],
                ),
              ),

              // Content
              Expanded(
                child: ListView(
                  padding: SizeUtils.of(context).basePadding,
                  // shrinkWrap: true,
                  children: children,
                ),
              ),

              // Action buttons
              Padding(
                  padding: SizeUtils.of(context).basePadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                          flex: 2,
                          child: TextButton(
                            onPressed: onCancel,
                            child: const Text('CANCEL'),
                          )),
                      const SizedBox(width: 5),
                      Flexible(
                        flex: 1,
                        child: SubmitButton(
                          child: const Text('SAVE'),
                          onPressed: onSubmit,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      );
}
