part of 'habit_bloc.dart';

sealed class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object> get props => [];
}

class HabitNameChanged extends HabitEvent {
  const HabitNameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

class HabitColorChanged extends HabitEvent {
  const HabitColorChanged(this.color);
  final Color color;

  @override
  List<Object> get props => [color];
}

class HabitIconChanged extends HabitEvent {
  const HabitIconChanged(this.icon);
  final IconData icon;

  @override
  List<Object> get props => [icon];
}

class HabitWeekdayToggled extends HabitEvent {
  const HabitWeekdayToggled(this.weekday);
  final String weekday;

  @override
  List<Object> get props => [weekday];
}

class HabitStartDateChanged extends HabitEvent {
  const HabitStartDateChanged(this.date);
  final DateTime date;

  @override
  List<Object> get props => [date];
}

class HabitEndDateChanged extends HabitEvent {
  const HabitEndDateChanged(this.date);
  final DateTime date;

  @override
  List<Object> get props => [date];
}

class HabitFormSubmitted extends HabitEvent {}

class HabitFormResetted extends HabitEvent {}
