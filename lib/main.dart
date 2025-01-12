import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

import 'app/view/app.dart';

void main() {
  final AuthenticationRepository authenticationRepository = AuthenticationRepository();
  runApp(
    App(
      authenticationRepository: authenticationRepository,
    ),
  );
}
