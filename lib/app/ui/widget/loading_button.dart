import 'package:flutter/material.dart';

class LoadingElevatedButton extends StatelessWidget {
  final bool loading;

  final Widget child;
  final void Function()? onPressed;

  const LoadingElevatedButton(
      {Key? key, this.loading = false, required this.child, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: loading ? null : onPressed,
        child: loading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox.square(
                      dimension: Theme.of(context).textTheme.button!.fontSize,
                      child: const CircularProgressIndicator(strokeWidth: 2)),
                ],
              )
            : child,
      );
}
