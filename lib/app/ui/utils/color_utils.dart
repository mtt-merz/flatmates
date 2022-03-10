import 'package:flutter/material.dart';

class ColorUtils {
  final Color color;

  ColorUtils(this.color);

  Color get textColor => color.computeLuminance() > 0.5 ? Colors.black : Colors.white;

  static List<Color> get availableColors => [...Colors.primaries]
    ..removeAt(0)
    ..removeLast()
    ..removeLast();
}
