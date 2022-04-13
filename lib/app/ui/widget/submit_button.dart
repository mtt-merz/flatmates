import 'package:flatmates/app/ui/widget/error_text.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;

  final bool loading;
  final String? error;

  const SubmitButton(
      {Key? key, required this.child, required this.onPressed, this.loading = false, this.error})
      : assert(loading && error == null || !loading),
        super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (error != null)
            Padding(padding: const EdgeInsets.only(bottom: 10), child: ErrorText(error!)),

          // Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(surfaceTintColor: Colors.black),
            onPressed: loading ? null : onPressed,
            child: SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: loading
                      ? SizedBox.square(
                          dimension: Theme.of(context).textTheme.button!.fontSize,
                          child: const CircularProgressIndicator(strokeWidth: 1.5))
                      : child,
                )),
          ),
        ],
      );
}
