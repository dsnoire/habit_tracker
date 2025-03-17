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

  Future<void> editHabit({
    required String habitId,
    required Habit updatedHabit,
  }) async {
    try {
      await _databaseClient.editHabit(
        habitId: habitId,
        updatedHabit: updatedHabit,
      );
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

  Stream<List<Habit>> getHabitsForConcreteDay({
    required String dayOfTheWeek,
    required DateTime selectedDate,
  }) {
    try {
      return _databaseClient.getHabitsForConcreteDay(
        dayOfTheWeek: dayOfTheWeek,
        selectedDate: selectedDate,
      );
    } on DatabaseFailure {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
