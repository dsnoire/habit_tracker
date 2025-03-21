import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habit.g.dart';

@JsonSerializable()
class Habit extends Equatable {
  const Habit({
    this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.weekdays,
    required this.startDate,
    this.endDate,
    this.isCompleted = false,
  });

  final String? id;
  final String name;
  final int color;
  final int icon;
  final Set<String> weekdays;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCompleted;

  Habit copyWith({
    String? id,
    String? name,
    int? color,
    int? icon,
    Set<String>? weekdays,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCompleted,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      weekdays: weekdays ?? this.weekdays,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        color,
        icon,
        weekdays,
        startDate,
        endDate,
        isCompleted,
      ];
}
