import 'dart:convert';
import 'package:equatable/equatable.dart';

class Habit extends Equatable {
  const Habit({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Habit.fromJson(String source) => Habit.fromMap(json.decode(source) as Map<String, dynamic>);
}
