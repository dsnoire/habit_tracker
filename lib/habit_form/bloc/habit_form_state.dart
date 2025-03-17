part of 'habit_form_bloc.dart';

class HabitFormState extends Equatable {
  const HabitFormState({
    required this.initialHabit,
    required this.name,
    required this.color,
    required this.icon,
    required this.weekdays,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.isValid,
    this.errorMessage,
  });

  final Habit? initialHabit;
  final HabitName name;
  final Color color;
  final IconData icon;
  final Set<String> weekdays;
  final DateTime startDate;
  final DateTime? endDate;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  bool get isNewHabit => initialHabit == null;

  @override
  List<Object?> get props => [
        initialHabit,
        name,
        color,
        icon,
        weekdays,
        startDate,
        endDate,
        status,
        isValid,
        errorMessage,
      ];

  HabitFormState copyWith({
    Habit? initialHabit,
    HabitName? name,
    Color? color,
    IconData? icon,
    Set<String>? weekdays,
    DateTime? startDate,
    DateTime? endDate,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return HabitFormState(
      initialHabit: initialHabit ?? this.initialHabit,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      weekdays: weekdays ?? this.weekdays,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
