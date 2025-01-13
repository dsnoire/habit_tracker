import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/register/bloc/register_bloc.dart';

import '../../app/colors/app_colors.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) => !previous.status.isFailure,
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Register failure'),
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
                _RegisterHeader(),
                const Spacer(),
                _EmailTextInput(),
                const SizedBox(height: 24),
                _PasswordTextInput(),
                const SizedBox(height: 24),
                _ConfirmPasswordTextInput(),
                const SizedBox(height: 24),
                _RegisterButton(),
                const SizedBox(height: 24),
                _NavigateToLoginButton(),
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
    final displayError = context.select((RegisterBloc bloc) => bloc.state.email.displayError);
    return TextField(
      onChanged: (value) => context.read<RegisterBloc>().add(RegisterEmailChanged(value)),
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
    final displayError = context.select((RegisterBloc bloc) => bloc.state.password.displayError);
    return TextField(
      onChanged: (value) => context.read<RegisterBloc>().add(RegisterPasswordChanged(value)),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_open_rounded),
        labelText: 'Password',
        errorText: displayError != null ? 'Invalid password' : null,
      ),
      obscureText: true,
    );
  }
}

class _ConfirmPasswordTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select((RegisterBloc bloc) => bloc.state.confirmedPassword.displayError);
    return TextField(
      onChanged: (value) => context.read<RegisterBloc>().add(RegisterConfirmedPasswordChanged(value)),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_rounded),
        labelText: 'Confirm password',
        errorText: displayError != null ? 'Passwords do not match' : null,
      ),
      obscureText: true,
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select((RegisterBloc bloc) => bloc.state.status.isInProgress);

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select((RegisterBloc bloc) => bloc.state.isValid);

    return ElevatedButton(
      onPressed: isValid ? () => context.read<RegisterBloc>().add(RegisterFormSubmitted()) : null,
      child: const Text('Register'),
    );
  }
}

class _NavigateToLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go('/login'),
      child: RichText(
        text: const TextSpan(
          text: 'Already have an account? ',
          style: TextStyle(
            color: AppColors.grey,
          ),
          children: [
            TextSpan(
              text: 'Log in here',
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

class _RegisterHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Create account',
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
