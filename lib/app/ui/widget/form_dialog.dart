import 'package:flatmates/app/ui/utils/size_utils.dart';
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
          insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 20, top: 18),
                child: Row(children: [Text(title, style: Theme.of(context).textTheme.headline5)]),
              ),
              // const Divider(),
              ListView(
                padding: SizeUtils.of(context).basePadding,
                shrinkWrap: true,
                children: children,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       onCancel != null
              //           ? TextButton(onPressed: onCancel!, child: const Text('Cancel'))
              //           : const SizedBox(),
              //       const SizedBox(width: 10),
              //       ElevatedButton(onPressed: onSubmit, child: const Text('SAVE'))
              //     ],
              //   ),
              // )
            ],
          ),
        ),
  );
}
