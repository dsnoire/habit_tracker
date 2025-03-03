part of 'habit_form_bloc.dart';

final class HabitFormState extends Equatable {
  HabitFormState({
    this.name = const HabitName.pure(),
    Color? color,
    IconData? icon,
    this.weekdays = const {},
    DateTime? startDate,
    this.endDate,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  })  : color = color ?? HabitColors.defaultColor,
        icon = icon ?? HabitIcons.defaultIcon,
        startDate = startDate ?? DateTime.now();

  final HabitName name;
  final Color color;
  final IconData icon;
  final Set<String> weekdays;
  final DateTime startDate;
  final DateTime? endDate;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        name,
        color,
        icon,
        weekdays,
        startDate,
        endDate,
        isValid,
        errorMessage,
      ];

  HabitFormState copyWith({
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
