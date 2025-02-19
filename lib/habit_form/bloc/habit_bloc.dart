import 'package:database_client/database_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_tracker/habit_form/widgets/color_picker.dart';
import 'package:habit_tracker/habit_form/widgets/icon_picker.dart';

part 'habit_event.dart';
part 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  HabitBloc(this._habitRepository) : super(HabitState()) {
    on<HabitNameChanged>(_onNameChanged);
    on<HabitFormSubmitted>(_onHabitFormSubmitted);
    on<HabitColorChanged>(_onColorChanged);
    on<HabitIconChanged>(_onIconChanged);
    on<HabitWeekdayToggled>(_onWeekdayToggled);
    on<HabitStartDateChanged>(_onStartDateChanged);
    on<HabitEndDateChanged>(_onEndDateChanged);
  }

  final HabitRepository _habitRepository;

  void _onNameChanged(
    HabitNameChanged event,
    Emitter<HabitState> emit,
  ) {
    final name = HabitName.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate(
          [name],
        ),
      ),
    );
  }

  void _onColorChanged(
    HabitColorChanged event,
    Emitter<HabitState> emit,
  ) {
    emit(state.copyWith(color: event.color));
  }

  void _onIconChanged(
    HabitIconChanged event,
    Emitter<HabitState> emit,
  ) {
    emit(state.copyWith(icon: event.icon));
  }

  void _onWeekdayToggled(
    HabitWeekdayToggled event,
    Emitter<HabitState> emit,
  ) {
    final updatedWeekdays = Set<String>.from(state.weekdays);
    final weekday = event.weekday;
    if (updatedWeekdays.contains(weekday)) {
      updatedWeekdays.remove(weekday);
    } else {
      updatedWeekdays.add(weekday);
    }
    emit(state.copyWith(weekdays: updatedWeekdays));
  }

  void _onStartDateChanged(
    HabitStartDateChanged event,
    Emitter<HabitState> emit,
  ) {
    emit(state.copyWith(startDate: event.date));
  }

  void _onEndDateChanged(
    HabitEndDateChanged event,
    Emitter<HabitState> emit,
  ) {
    emit(state.copyWith(endDate: event.date));
  }

  Future<void> _onHabitFormSubmitted(
    HabitEvent event,
    Emitter<HabitState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _habitRepository.addHabit(
        Habit(
          id: '',
          name: state.name.value,
          color: state.color.value,
          icon: state.icon.toString(),
          weekdays: state.weekdays,
          startDate: state.startDate,
          endDate: state.endDate,
        ),
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on DatabaseFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
