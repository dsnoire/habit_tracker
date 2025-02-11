import 'package:formz/formz.dart';

enum HabitNameValidationError { invalid }

class HabitName extends FormzInput<String, HabitNameValidationError> {
  const HabitName.pure() : super.pure('');

  const HabitName.dirty(super.value) : super.dirty();

  @override
  HabitNameValidationError? validator(String value) {
    return value.isNotEmpty ? null : HabitNameValidationError.invalid;
  }
}
