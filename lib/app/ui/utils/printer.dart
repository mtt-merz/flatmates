import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Printer {
  /// General utils

  static String capitalize(String text) =>
      text[0].toUpperCase() + text.substring(1);

  /// OBJECTS

  static String date(DateTime date) => '${date.day}-${date.month}-${date.year}';

  static String dateVerbose(DateTime date) {
    final today = DateTime.now();

    final day = date.day;
    final month = date.month;
    final year = date.year;

    final weekDay = DateFormat.EEEE().format(date);
    // final weekDay = DateFormat.EEEE('it').format(date);
    final monthVerbose = DateFormat.MMMM().format(date);
    // final monthVerbose = DateFormat.MMMM('it').format(date);

    // Yesterday
    if (year == today.year && month == today.month && day == today.day - 1)
      return 'yesterday';

    // Today
    if (year == today.year && month == today.month && day == today.day)
      return 'today';

    // Tomorrow
    if (year == today.year && month == today.month && day == today.day + 1)
      return 'tomorrow';

    // Same year
    if (year == today.year) return '$weekDay $day $monthVerbose';

    //Other
    return '$weekDay $day $monthVerbose $year';
  }

  static String timeFromDate(DateTime date) =>
      time(TimeOfDay(hour: date.hour, minute: date.minute));

  static String time(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  static String dateTime(DateTime dateTime) =>
      date(dateTime) + ' ' + time(TimeOfDay.fromDateTime(dateTime));
}
