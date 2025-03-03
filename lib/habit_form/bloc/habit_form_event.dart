part of 'habit_form_bloc.dart';

sealed class HabitFormEvent extends Equatable {
  const HabitFormEvent();

  @override
  List<Object> get props => [];
}

final class HabitNameChanged extends HabitFormEvent {
  const HabitNameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

final class HabitColorChanged extends HabitFormEvent {
  const HabitColorChanged(this.color);
  final Color color;

  @override
  List<Object> get props => [color];
}

final class HabitIconChanged extends HabitFormEvent {
  const HabitIconChanged(this.icon);
  final IconData icon;

  @override
  List<Object> get props => [icon];
}

final class HabitWeekdayToggled extends HabitFormEvent {
  const HabitWeekdayToggled(this.weekday);
  final String weekday;

  @override
  List<Object> get props => [weekday];
}

final class HabitStartDateChanged extends HabitFormEvent {
  const HabitStartDateChanged(this.date);
  final DateTime date;

  @override
  List<Object> get props => [date];
}

final class HabitEndDateChanged extends HabitFormEvent {
  const HabitEndDateChanged(this.date);
  final DateTime date;

  @override
  List<Object> get props => [date];
}

final class HabitFormSubmitted extends HabitFormEvent {}
