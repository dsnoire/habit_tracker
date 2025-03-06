import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';
import '../../app/widgets/app_loading_indicator.dart';
import '../../habits_overview/bloc/habits_overview_bloc.dart';
import '../../habits_overview/view/habits_overview_view.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: AppSpacing.xxxlg,
          ),
          child: Column(
            children: [
              Text(
                'Habits',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              BlocBuilder<HabitsOverviewBloc, HabitsOverviewState>(
                builder: (context, state) {
                  if (state.status == HabitsOverviewStatus.loading) {
                    return AppLoadingIndicator();
                  } else if (state.status == HabitsOverviewStatus.failure) {
                    return Text('Error');
                  } else if (state.habits.isEmpty) {
                    return _NoHabitsInformation();
                  } else {
                    return HabitsOverviewView(
                      habits: state.habits,
                      hasCompletionStatus: false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoHabitsInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'No habits added.',
      style: TextStyle(
        color: AppColors.whiteShadow,
      ),
    );
  }
}
