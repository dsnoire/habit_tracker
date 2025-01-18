import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/bloc/app_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../../app/colors/app_colors.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            _AccountInformation(
              user: user,
            ),
            const SizedBox(height: 16),
            _SettingsTile(
              icon: Icons.person_outline,
              title: 'Account',
            ),
            _SettingsTile(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
            ),
            _SettingsTile(
              icon: Icons.remove_red_eye_outlined,
              title: 'Appearance',
            ),
            Spacer(),
            _LogOutButton(),
          ],
        ),
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => context.read<AppBloc>().add(AppLogOutPressed()),
      label: Text(
        'Log out',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.red,
        ),
      ),
      icon: Icon(
        Icons.logout_outlined,
        size: 24,
        color: AppColors.red,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.surfaceGrey,
      contentPadding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      leading: CircleAvatar(
        backgroundColor: AppColors.white,
        child: Icon(
          icon,
          color: AppColors.darkGrey,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColors.grey,
      ),
    );
  }
}

class _AccountInformation extends StatelessWidget {
  final UserModel user;
  const _AccountInformation({
    required this.user,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.grey,
            radius: 36,
          ),
          const SizedBox(height: 8),
          Text(
            user.email ?? '',
          ),
        ],
      ),
    );
  }
}
