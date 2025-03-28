import 'package:database_client/database_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';

part 'habits_overview_event.dart';
part 'habits_overview_state.dart';

class HabitsOverviewBloc
    extends Bloc<HabitsOverviewEvent, HabitsOverviewState> {
  HabitsOverviewBloc(this._habitRepository) : super(HabitsOverviewState()) {
    on<HabitsOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<HabitsOverviewByDateRequested>(_onSubscriptionByDateRequested);
    on<HabitsOverviewCompletionToggled>(_onCompletionToggled);
    on<HabitsOverviewHabitDeleted>(_onHabitDeleted);
  }

  final HabitRepository _habitRepository;

  Future<void> _onSubscriptionRequested(
    HabitsOverviewSubscriptionRequested event,
    Emitter<HabitsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: HabitsOverviewStatus.loading));
    try {
      final habits = _habitRepository.getAllHabits();
      return await emit.forEach<List<Habit>>(
        habits,
        onData: (habits) => state.copyWith(
          status: HabitsOverviewStatus.success,
          habits: habits,
        ),
        onError: (error, _) => state.copyWith(
          status: HabitsOverviewStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    } on DatabaseFailure catch (e) {
      emit(
        state.copyWith(
          status: HabitsOverviewStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: HabitsOverviewStatus.failure));
    }
  }

  Future<void> _onSubscriptionByDateRequested(
    HabitsOverviewByDateRequested event,
    Emitter<HabitsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: HabitsOverviewStatus.loading));
    try {
      final habits = _habitRepository.getHabitsForConcreteDay(
        dayOfTheWeek: event.dayOfTheWeek,
        selectedDate: event.selectedDate,
      );
      return await emit.forEach<List<Habit>>(
        habits,
        onData: (habits) => state.copyWith(
          status: HabitsOverviewStatus.success,
          filteredHabits: habits,
        ),
        onError: (error, _) => state.copyWith(
          status: HabitsOverviewStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    } on DatabaseFailure catch (e) {
      emit(
        state.copyWith(
          status: HabitsOverviewStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: HabitsOverviewStatus.failure));
    }
  }

  Future<void> _onCompletionToggled(
    HabitsOverviewCompletionToggled event,
    Emitter<HabitsOverviewState> emit,
  ) async {
    try {
      final updatedHabit = event.habit.copyWith(isCompleted: event.isCompleted);
      await _habitRepository.addOrUpdateHabit(updatedHabit);
    } on DatabaseFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: HabitsOverviewStatus.failure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(status: HabitsOverviewStatus.failure),
      );
    }
  }

  Future<void> _onHabitDeleted(
    HabitsOverviewHabitDeleted event,
    Emitter<HabitsOverviewState> emit,
  ) async {
    emit(state.copyWith(status: HabitsOverviewStatus.loading));
    try {
      final habitId = event.habit.id;
      if (habitId == null) return;

      await Future.delayed(Duration(seconds: 3));
      await _habitRepository.removeHabit(habitId);
      emit(state.copyWith(status: HabitsOverviewStatus.success));
    } on DatabaseFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: HabitsOverviewStatus.failure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(status: HabitsOverviewStatus.failure),
      );
    }
  }
}
