import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String get dayOfTheWeek => DateFormat('EEEE').format(this);
  String get dayName => DateFormat('EEE').format(this);
  String get monthDayYear => DateFormat('MMM d yyyy').format(this);
  String get displayTodayOrDate {
    final now = DateTime.now();
    return (year == now.year && month == now.month && day == now.day)
        ? 'Today'
        : DateFormat('MMM d yyyy').format(this);
  }
}
