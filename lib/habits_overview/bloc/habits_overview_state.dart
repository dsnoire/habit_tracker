part of 'habits_overview_bloc.dart';

enum HabitsOverviewStatus { initial, loading, success, failure }

final class HabitsOverviewState extends Equatable {
  const HabitsOverviewState({
    this.status = HabitsOverviewStatus.initial,
    this.habits = const [],
    this.filteredHabits = const [],
    this.errorMessage,
  });

  final HabitsOverviewStatus status;
  final List<Habit> habits;
  final List<Habit> filteredHabits;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        status,
        habits,
        filteredHabits,
        errorMessage,
      ];

  HabitsOverviewState copyWith({
    HabitsOverviewStatus? status,
    List<Habit>? habits,
    List<Habit>? filteredHabits,
    String? errorMessage,
  }) {
    return HabitsOverviewState(
      status: status ?? this.status,
      habits: habits ?? this.habits,
      filteredHabits: filteredHabits ?? this.filteredHabits,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
