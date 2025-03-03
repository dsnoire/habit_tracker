import 'package:authentication_repository/authentication_repository.dart';
import 'package:database_client/database_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'package:habit_tracker/firebase_options.dart';
import 'app/bloc_observer.dart';
import 'app/view/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final databaseClient = DatabaseClient();
  final authenticationRepository = AuthenticationRepository();
  final userRepository = UserRepository(databaseClient: databaseClient);
  final habitRepository = HabitRepository(databaseClient);
  runApp(
    App(
      authenticationRepository: authenticationRepository,
      userRepository: userRepository,
      habitRepository: habitRepository,
    ),
  );
}
