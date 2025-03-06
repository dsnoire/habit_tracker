import 'package:database_client/database_client.dart';

class HabitRepository {
  HabitRepository(this._databaseClient);
  final DatabaseClient _databaseClient;

  Future<void> addOrUpdateHabit(Habit habit) async {
    try {
      await _databaseClient.addOrUpdateHabit(habit);
    } on DatabaseFailure {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> removeHabit(String habitId) async {
    try {
      await _databaseClient.removeHabit(habitId);
    } on DatabaseFailure {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> editHabit(String habitId, Habit updatedHabit) async {
    try {
      await _databaseClient.editHabit(habitId, updatedHabit);
    } on DatabaseFailure {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Stream<List<Habit>> getAllHabits() {
    try {
      return _databaseClient.getAllHabits();
    } on DatabaseFailure {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Stream<List<Habit>> getHabitsForConcreteDay(
    String weekday,
    DateTime selectedDate,
  ) {
    try {
      return _databaseClient.getHabitsForConcreteDay(
        weekday,
        selectedDate,
      );
    } on DatabaseFailure {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
