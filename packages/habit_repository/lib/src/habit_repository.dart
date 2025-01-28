import 'package:database_client/database_client.dart';

class HabitRepository {
  HabitRepository(this._databaseClient);
  final DatabaseClient _databaseClient;

  Future<void> addHabit(Habit habit) async {
    try {
      await _databaseClient.addHabit(habit);
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

  Future<List<Habit>> getAllHabits() async {
    try {
      return await _databaseClient.getAllHabits();
    } on DatabaseFailure {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
