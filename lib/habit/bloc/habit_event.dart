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

class HabitFormSubmitted extends HabitEvent {}
