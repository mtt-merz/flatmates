import 'package:flutter/material.dart';

class SizeUtils {
  static SizeUtils of(BuildContext context) => SizeUtils._(context);

  final BuildContext _context;

  SizeUtils._(this._context);

  double getScaledHeight(double percentage) =>
      MediaQuery.of(_context).size.height * percentage / 100;

  double getScaledWidth(double percentage) =>
      MediaQuery.of(_context).size.width * percentage / 100;

  double get horizontalPaddingValue => getScaledWidth(5);

  double get verticalPaddingValue => getScaledHeight(2);

  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: horizontalPaddingValue);

  EdgeInsetsGeometry get basePadding => EdgeInsets.symmetric(
      horizontal: horizontalPaddingValue, vertical: verticalPaddingValue);

  EdgeInsetsGeometry get screenPadding =>
      basePadding.add(EdgeInsets.only(top: getScaledHeight(5)));
}
