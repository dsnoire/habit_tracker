part of 'habits_overview_bloc.dart';

sealed class HabitsOverviewEvent extends Equatable {
  const HabitsOverviewEvent();

  @override
  List<Object> get props => [];
}

final class HabitsOverviewSubscriptionRequested extends HabitsOverviewEvent {}

final class HabitsOverviewByDateRequested extends HabitsOverviewEvent {
  const HabitsOverviewByDateRequested(
    this.dayOfTheWeek,
    this.selectedDate,
  );
  final String dayOfTheWeek;
  final DateTime selectedDate;

  @override
  List<Object> get props => [
        dayOfTheWeek,
        selectedDate,
      ];
}

final class HabitsOverviewCompletionToggled extends HabitsOverviewEvent {
  const HabitsOverviewCompletionToggled({
    required this.habit,
    required this.isCompleted,
  });

  final Habit habit;
  final bool isCompleted;

  @override
  List<Object> get props => [
        habit,
        isCompleted,
      ];
}

final class HabitsOverviewHabitDeleted extends HabitsOverviewEvent {
  const HabitsOverviewHabitDeleted(this.habit);

  final Habit habit;

  @override
  List<Object> get props => [habit];
}
