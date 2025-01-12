import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/firebase_options.dart';

import 'app/view/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final AuthenticationRepository authenticationRepository = AuthenticationRepository();
  runApp(
    App(authenticationRepository: authenticationRepository),
  );
}
