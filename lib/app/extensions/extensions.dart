import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  String get dayOfTheWeek => DateFormat('EEEE').format(this);
  String get dayName => DateFormat('EEE').format(this);
}
