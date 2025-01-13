import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../app/colors/app_colors.dart';
import '../bloc/login_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => !previous.status.isFailure,
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Login failure'),
              ),
            );
        }
      },
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 70),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LoginHeader(),
                const Spacer(),
                _EmailTextInput(),
                const SizedBox(height: 24),
                _PasswordTextInput(),
                const SizedBox(height: 24),
                _LoginButton(),
                const SizedBox(height: 24),
                _NavigateToRegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select((LoginBloc bloc) => bloc.state.email.displayError);
    return TextField(
      onChanged: (value) => context.read<LoginBloc>().add(LoginEmailChanged(value)),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        labelText: 'E-mail',
        errorText: displayError != null ? 'Invalid email' : null,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class _PasswordTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select((LoginBloc bloc) => bloc.state.password.displayError);
    return TextField(
      onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(value)),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_open_rounded),
        labelText: 'Password',
        errorText: displayError != null ? 'Invalid password' : null,
      ),
      obscureText: true,
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select((LoginBloc bloc) => bloc.state.status.isInProgress);

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select((LoginBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      onPressed: isValid ? () => context.read<LoginBloc>().add(LoginFormSubmitted()) : null,
      child: const Text('Login'),
    );
  }
}

class _NavigateToRegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go('/register'),
      child: RichText(
        text: const TextSpan(
          text: 'Don\'t have an account yet? ',
          style: TextStyle(
            color: AppColors.grey,
          ),
          children: [
            TextSpan(
              text: 'Register here',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Login',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        SvgPicture.asset(
          'assets/images/auth.svg',
          height: 220,
        ),
      ],
    );
  }
}
