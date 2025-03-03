part of 'habits_overview_bloc.dart';

sealed class HabitsOverviewEvent extends Equatable {
  const HabitsOverviewEvent();

  @override
  List<Object> get props => [];
}

final class HabitsOverviewSubscriptionRequested extends HabitsOverviewEvent {}

final class HabitsOverviewByDateRequested extends HabitsOverviewEvent {
  const HabitsOverviewByDateRequested(
    this.weekday,
    this.selectedDate,
  );
  final String weekday;
  final DateTime selectedDate;

  @override
  List<Object> get props => [
        weekday,
        selectedDate,
      ];
}
