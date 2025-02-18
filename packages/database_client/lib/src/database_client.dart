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
      throw DatabaseClient();
    }
  }

  Future<void> addHabit(Habit habit) async {
    try {
      final docRef = _firestore
          .collection('users')
          .doc(_userId)
          .collection('habits')
          .doc();
      final habitWithId = habit.copyWith(id: docRef.id);

      await docRef.set(habitWithId.toJson());
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

  Future<void> editHabit(String habitId, Habit updatedHabit) async {
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

  Future<List<Habit>> getAllHabits() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('habits')
          .get();
      return snapshot.docs.map((doc) => Habit.fromJson(doc.data())).toList();
    } on FirebaseException catch (e) {
      throw DatabaseFailure.fromCode(e.code);
    } catch (_) {
      throw DatabaseFailure();
    }
  }
}
