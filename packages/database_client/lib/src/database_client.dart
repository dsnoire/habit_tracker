import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_client/database_client.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseFailure implements Exception {
  const DatabaseFailure([this.message = 'An unknown exception occured.']);
  final String message;

  factory DatabaseFailure.fromCode(String code) {
    switch (code) {
      case 'permission-denied':
        return DatabaseFailure(
            'You do not have permission to perform this operation.');
      case 'unavailable':
        return DatabaseFailure('The service is currently unavailable.');
      case 'not-found':
        return DatabaseFailure('The requested document was not found.');
      case 'invalid-argument':
        return DatabaseFailure('The query or data provided is invalid.');
      case 'aborted':
        return DatabaseFailure('The operation was aborted. Please try again.');
      case 'network-request-failed':
        return DatabaseFailure(
            'Network request error. Please check your internet connection.');
      default:
        return DatabaseFailure();
    }
  }
}

class DatabaseClient {
  DatabaseClient({
    FirebaseFirestore? firestore,
    FirebaseAuth? firebaseAuth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  String get _userId => _firebaseAuth.currentUser!.uid;

  Future<void> createUser({required UserModel user}) async {
    try {
      await _firestore.collection('users').doc(_userId).set({
        'createdAt': FieldValue.serverTimestamp(),
        'email': user.email,
      });
    } on FirebaseException catch (e) {
      throw DatabaseFailure.fromCode(e.code);
    } catch (_) {
      throw DatabaseFailure();
    }
  }

  Future<void> addOrUpdateHabit(Habit habit) async {
    try {
      final collectionRef =
          _firestore.collection('users').doc(_userId).collection('habits');

      final docRef =
          habit.id != null ? collectionRef.doc(habit.id) : collectionRef.doc();

      final habitWithId = habit.copyWith(id: docRef.id);

      await docRef.set(
        habitWithId.toJson(),
        SetOptions(merge: true),
      );
    } on FirebaseException catch (e) {
      throw DatabaseFailure.fromCode(e.code);
    } catch (_) {
      throw DatabaseFailure();
    }
  }

  Future<void> removeHabit(String habitId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('habits')
          .doc(habitId)
          .delete();
    } on FirebaseException catch (e) {
      throw DatabaseFailure.fromCode(e.code);
    } catch (_) {
      throw DatabaseFailure();
    }
  }

  Future<void> editHabit({
    required String habitId,
    required Habit updatedHabit,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('habits')
          .doc(habitId)
          .update(updatedHabit.toJson());
    } on FirebaseException catch (e) {
      throw DatabaseFailure.fromCode(e.code);
    } catch (_) {
      throw DatabaseFailure();
    }
  }

  Stream<List<Habit>> getAllHabits() {
    try {
      final snapshots = _firestore
          .collection('users')
          .doc(_userId)
          .collection('habits')
          .snapshots();
      return snapshots.map(
        (snapshot) =>
            snapshot.docs.map((doc) => Habit.fromJson(doc.data())).toList(),
      );
    } on FirebaseException catch (e) {
      throw DatabaseFailure.fromCode(e.code);
    } catch (_) {
      throw DatabaseFailure();
    }
  }

  Stream<List<Habit>> getHabitsForConcreteDay({
    required String dayOfTheWeek,
    required DateTime selectedDate,
  }) {
    try {
      final snapshots = _firestore
          .collection('users')
          .doc(_userId)
          .collection('habits')
          .where('weekdays', arrayContains: dayOfTheWeek)
          .snapshots();

      return snapshots.map(
        (snapshot) => snapshot.docs
            .map((doc) => Habit.fromJson(doc.data()))
            .where(
              (habit) => habit.isWithinDateRange(
                selectedDate: selectedDate,
                habit: habit,
              ),
            )
            .toList(),
      );
    } on FirebaseException catch (e) {
      throw DatabaseFailure.fromCode(e.code);
    } catch (_) {
      throw DatabaseFailure();
    }
  }
}

extension DateRange on Habit {
  bool isWithinDateRange({
    required DateTime selectedDate,
    required Habit habit,
  }) {
    final selected = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    final startDate = DateTime(
      habit.startDate.year,
      habit.startDate.month,
      habit.startDate.day,
    );
    DateTime? endDate = habit.endDate != null
        ? DateTime(
            habit.endDate!.year,
            habit.endDate!.month,
            habit.endDate!.day,
          )
        : null;

    return selected.isAtSameMomentAs(startDate) ||
        selected.isAfter(startDate) &&
            (endDate == null || selectedDate.isBefore(endDate));
  }
}
