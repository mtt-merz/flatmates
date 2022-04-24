import 'package:flatmates/app/ui/utils/size_utils.dart';
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
              Padding(
                padding: SizeUtils.of(context).horizontalPadding.add(
                    EdgeInsets.only(
                        top: SizeUtils.of(context).horizontalPaddingValue,
                        bottom:
                            SizeUtils.of(context).horizontalPaddingValue / 2)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.headline5),
                    InkWell(child: const Icon(Icons.close), onTap: onCancel)
                  ],
                ),
              ),
              // const Divider(),
              Expanded(
                child: ListView(
                  padding: SizeUtils.of(context).basePadding,
                  // shrinkWrap: true,
                  children: children,
                ),
              ),
              Padding(
                  padding: SizeUtils.of(context).horizontalPadding.add(
                      EdgeInsets.symmetric(
                          vertical:
                              SizeUtils.of(context).verticalPaddingValue / 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                          flex: 3,
                          child: TextButton(
                            onPressed: onCancel,
                            child: const Text('CANCEL'),
                          )),
                      const SizedBox(width: 5),
                      Flexible(
                        flex: 2,
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
