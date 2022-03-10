import 'package:flutter/material.dart';

class SizeUtils {
  static SizeUtils of(BuildContext context) => SizeUtils._(context);

  final BuildContext _context;

  SizeUtils._(this._context);

  double getScaledHeight(double percentage) => MediaQuery.of(_context).size.height * percentage / 100;

  double getScaledWidth(double percentage) => MediaQuery.of(_context).size.width * percentage / 100;

  EdgeInsetsGeometry get basePadding =>
      EdgeInsets.symmetric(horizontal: getScaledWidth(4), vertical: getScaledHeight(2.5));

  EdgeInsetsGeometry get screenPadding => basePadding.add(EdgeInsets.only(top: getScaledHeight(5)));
}
