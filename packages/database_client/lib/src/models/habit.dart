import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habit.g.dart';

@JsonSerializable()
class Habit extends Equatable {
  const Habit({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);

  @override
  List<Object> get props => [id, name];
}
