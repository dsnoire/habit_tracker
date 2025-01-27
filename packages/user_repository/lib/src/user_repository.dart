import 'package:database_client/database_client.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  UserRepository({
    FirebaseAuth? firebaseAuth,
    required DatabaseClient databaseClient,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _databaseClient = databaseClient;

  final FirebaseAuth _firebaseAuth;
  final DatabaseClient _databaseClient;

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

  Future<void> createUser() async {
    final user = currentUser;
    if (user == null) return;
    await _databaseClient.createUser(user: user);
  }
}

extension on User {
  UserModel get toUser {
    return UserModel(id: uid, name: displayName ?? '', email: email);
  }
}
