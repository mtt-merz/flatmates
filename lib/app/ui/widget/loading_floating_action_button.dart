import 'package:flutter/material.dart';

class LoadingFloatingActionButton extends FloatingActionButton {
  LoadingFloatingActionButton({
    Key? key,
    required String label,
    required IconData iconData,
    required VoidCallback? onPressed,
    required bool isLoading,
  }) : super.extended(
            key: key,
            label: isLoading
                ? const SizedBox.square(
                    dimension: 24,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                  )
                : Row(children: [
                    Text(label.toUpperCase()),
                    const SizedBox(width: 6),
                    Icon(iconData),
                  ]),
            onPressed: onPressed);
}
