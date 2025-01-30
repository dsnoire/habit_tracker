import 'package:authentication_repository/authentication_repository.dart';
import 'package:database_client/database_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

import 'package:habit_tracker/firebase_options.dart';
import 'app/view/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final databaseClient = DatabaseClient();
  final authenticationRepository = AuthenticationRepository();
  final userRepository = UserRepository(databaseClient: databaseClient);
  runApp(
    App(
      authenticationRepository: authenticationRepository,
      userRepository: userRepository,
    ),
  );
}
