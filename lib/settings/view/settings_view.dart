import 'package:database_client/database_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/bloc/app_bloc.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.lg,
        children: [
          const SizedBox(height: AppSpacing.lg),
          _SettingsTile(
            icon: Icons.person_outline,
            title: 'Account',
            subtitle: user.email,
          ),
          _Divider(),
          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
          ),
          _Divider(),
          _SettingsTile(
            icon: Icons.remove_red_eye_outlined,
            title: 'Appearance',
          ),
          Spacer(),
          _LogOutButton(),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.surfaceGrey,
      indent: 12,
      endIndent: 12,
      thickness: 0.6,
    );
  }
}

class _LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: TextButton.icon(
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
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
  });
  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.surfaceGrey,
        child: Icon(
          icon,
          color: AppColors.white,
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
        size: 16,
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
    );
  }
}
