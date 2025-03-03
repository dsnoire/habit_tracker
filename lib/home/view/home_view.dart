import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';
import '../../app/widgets/app_loading_indicator.dart';
import '../../habits_overview/bloc/habits_overview_bloc.dart';
import '../../habits_overview/view/habits_overview_view.dart';
import '../widgets/home_drawer.dart';
import '../widgets/horizontal_date_picker.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
            const SizedBox(height: AppSpacing.xlg),
            BlocBuilder<HabitsOverviewBloc, HabitsOverviewState>(
              builder: (context, state) {
                if (state.status == HabitsOverviewStatus.loading) {
                  return AppLoadingIndicator();
                } else if (state.status == HabitsOverviewStatus.failure) {
                  return Text('Error');
                } else if (state.filteredHabits.isEmpty) {
                  return _NoHabitsScheduledInformation();
                } else {
                  return HabitsOverviewView(habits: state.filteredHabits);
                }
              },
            ),
          ],
        ),
      ),
      drawer: HomeDrawer(),
    );
  }
}

class _NoHabitsScheduledInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/empty_data.svg',
            height: 150,
          ),
          const SizedBox(height: AppSpacing.xxxlg),
          Text(
            "No habits scheduled for this day.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.whiteShadow,
            ),
          ),
        ],
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
