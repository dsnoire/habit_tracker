import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../app/colors/app_colors.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              _NavigateToSignInButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        labelText: 'E-mail',
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class _PasswordTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_open_rounded),
        labelText: 'Password',
      ),
      obscureText: true,
    );
  }
}

class _ConfirmPasswordTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_rounded),
        labelText: 'Confirm password',
      ),
      obscureText: true,
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Register'),
    );
  }
}

class _NavigateToSignInButton extends StatelessWidget {
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
