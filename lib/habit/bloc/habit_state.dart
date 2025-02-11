part of 'habit_bloc.dart';

final class HabitState extends Equatable {
  const HabitState({
    this.name = const HabitName.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final HabitName name;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [name, status, isValid, errorMessage];

  HabitState copyWith({
    HabitName? name,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return HabitState(
      name: name ?? this.name,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
