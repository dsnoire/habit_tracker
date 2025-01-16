import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/register/bloc/register_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocProvider(
            create: (context) => RegisterBloc(
              context.read<AuthenticationRepository>(),
              context.read<UserRepository>(),
            ),
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}
