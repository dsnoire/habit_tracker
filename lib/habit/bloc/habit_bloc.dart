import 'package:database_client/database_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:habit_repository/habit_repository.dart';

part 'habit_event.dart';
part 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  HabitBloc(this._habitRepository) : super(const HabitState()) {
    on<HabitNameChanged>(_onNameChanged);
    on<HabitFormSubmitted>(_onHabitFormSubmitted);
  }

  final HabitRepository _habitRepository;

  void _onNameChanged(HabitNameChanged event, Emitter<HabitState> emit) {
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

  Future<void> _onHabitFormSubmitted(HabitEvent event, Emitter<HabitState> emit) async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _habitRepository.addHabit(
        Habit(
          id: '1',
          name: state.name.value,
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
