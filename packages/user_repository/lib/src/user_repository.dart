import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/models/user_model.dart';

class UserRepository {
  UserRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firebaseFirestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  UserModel? currentUser;

  Stream<UserModel> get userStream {
    return _firebaseAuth.authStateChanges().map(
      (firebaseUser) {
        final user = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
        currentUser = user;
        return user;
      },
    );
  }

  Future<void> createUserCollection() async {
    final user = currentUser;
    if (user == null) return;

    final usersCollection = _firebaseFirestore.collection('users').doc(user.id);
    await usersCollection.set(
      {
        'name': user.name,
        'email': user.email,
        'createdAt': Timestamp.now(),
      },
    );
  }
}

extension on User {
  UserModel get toUser {
    return UserModel(id: uid, name: displayName ?? '', email: email);
  }
}
