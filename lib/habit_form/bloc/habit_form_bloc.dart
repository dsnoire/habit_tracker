import 'package:database_client/database_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:habit_repository/habit_repository.dart';

import '../widgets/color_picker.dart';
import '../widgets/icon_picker.dart';

part 'habit_form_event.dart';
part 'habit_form_state.dart';

class HabitFormBloc extends Bloc<HabitFormEvent, HabitFormState> {
  HabitFormBloc({
    required HabitRepository habitRepository,
    Habit? initialHabit,
  })  : _habitRepository = habitRepository,
        super(
          HabitFormState(
            initialHabit: initialHabit,
            name: initialHabit == null
                ? HabitName.pure()
                : HabitName.dirty(initialHabit.name),
            color: Color(initialHabit?.color ?? HabitColors.defaultColor.value),
            icon: IconData(
              initialHabit?.icon ?? HabitIcons.defaultIcon.codePoint,
              fontFamily: 'MaterialIcons',
            ),
            weekdays: initialHabit?.weekdays ?? {},
            startDate: initialHabit?.startDate ?? DateTime.now(),
            endDate: initialHabit?.endDate,
            status: FormzSubmissionStatus.initial,
            isValid: false,
          ),
        ) {
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
    Emitter<HabitFormState> emit,
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
    Emitter<HabitFormState> emit,
  ) {
    emit(state.copyWith(color: event.color));
  }

  void _onIconChanged(
    HabitIconChanged event,
    Emitter<HabitFormState> emit,
  ) {
    emit(state.copyWith(icon: event.icon));
  }

  void _onWeekdayToggled(
    HabitWeekdayToggled event,
    Emitter<HabitFormState> emit,
  ) {
    final updatedWeekdays = Set<String>.from(state.weekdays);
    final weekday = event.weekday;
    if (updatedWeekdays.contains(weekday)) {
      if (updatedWeekdays.length > 1) {
        updatedWeekdays.remove(weekday);
      }
    } else {
      updatedWeekdays.add(weekday);
    }
    emit(state.copyWith(weekdays: updatedWeekdays));
  }

  void _onStartDateChanged(
    HabitStartDateChanged event,
    Emitter<HabitFormState> emit,
  ) {
    emit(state.copyWith(startDate: event.date));
  }

  void _onEndDateChanged(
    HabitEndDateChanged event,
    Emitter<HabitFormState> emit,
  ) {
    emit(state.copyWith(endDate: event.date));
  }

  Future<void> _onHabitFormSubmitted(
    HabitFormSubmitted event,
    Emitter<HabitFormState> emit,
  ) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _habitRepository.addOrUpdateHabit(
        Habit(
          id: state.isNewHabit ? null : state.initialHabit!.id,
          name: state.name.value,
          color: state.color.value,
          icon: state.icon.codePoint,
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
