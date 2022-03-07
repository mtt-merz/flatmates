import 'package:flutter/material.dart';

class SizeUtils {
  static SizeUtils of(BuildContext context) => SizeUtils._(context);

  final BuildContext _context;

  SizeUtils._(this._context);

  double getScaledHeight(int percentage) => MediaQuery.of(_context).size.height * percentage / 100;

  double getScaledWidth(int percentage) => MediaQuery.of(_context).size.width * percentage / 100;

  EdgeInsetsGeometry get defaultPadding =>
      EdgeInsets.symmetric(horizontal: getScaledWidth(4), vertical: getScaledHeight(4))
          .add(EdgeInsets.only(top: getScaledHeight(5)));
}
