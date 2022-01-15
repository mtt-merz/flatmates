import 'package:flutter/material.dart';

class ColorUtils {
  final Color color;

  ColorUtils(this.color);

  Color get textColor => color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}
