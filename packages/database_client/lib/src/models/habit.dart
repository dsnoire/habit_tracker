import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habit.g.dart';

@JsonSerializable()
class Habit extends Equatable {
  const Habit({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.weekdays,
    required this.startDate,
    this.endDate,
  });

  final String id;
  final String name;
  final int color;
  final String icon;
  final Set<String> weekdays;
  final DateTime startDate;
  final DateTime? endDate;

  Habit copyWith({
    String? id,
    String? name,
    int? color,
    String? icon,
    Set<String>? weekdays,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      weekdays: weekdays ?? this.weekdays,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
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
      ];
}
