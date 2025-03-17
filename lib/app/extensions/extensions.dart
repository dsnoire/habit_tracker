import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String get dayOfTheWeek => DateFormat('EEEE').format(this);
  String get dayName => DateFormat('EEE').format(this);
  String get monthDayYear => DateFormat('MMM d yyyy').format(this);
}
