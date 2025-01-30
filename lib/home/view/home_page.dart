import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';
import '../widgets/horizontal_date_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today'),
        centerTitle: true,
        actions: [
          _SettingsButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            HorizontalDatePicker(),
          ],
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: IconButton(
        onPressed: () => context.push('/settings'),
        icon: Icon(
          Icons.settings,
          color: AppColors.white,
        ),
      ),
    );
  }
}
