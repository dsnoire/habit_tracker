import 'package:database_client/database_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';
import '../bloc/habits_overview_bloc.dart';

class HabitsOverviewView extends StatelessWidget {
  const HabitsOverviewView({
    super.key,
    required this.habits,
    this.hasCompletionStatus = true,
  });
  final List<Habit> habits;
  final bool hasCompletionStatus;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: habits.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final habit = habits[index];
          return _HabitListTile(
            habit: habit,
            hasCompletionStatus: hasCompletionStatus,
          );
        },
      ),
    );
  }
}

class _HabitListTile extends StatelessWidget {
  const _HabitListTile({
    required this.habit,
    required this.hasCompletionStatus,
  });
  final Habit habit;
  final bool hasCompletionStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceGrey,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Color(habit.color),
            child: _HabitIcon(habit: habit),
          ),
          const SizedBox(width: AppSpacing.xlg),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                habit.name.length > 10
                    ? '${habit.name.substring(0, 10)}...'
                    : habit.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                hasCompletionStatus
                    ? habit.isCompleted
                        ? 'Completed'
                        : 'Pending'
                    : 'Habit',
                style: TextStyle(
                  fontSize: 13,
                  color: hasCompletionStatus
                      ? habit.isCompleted
                          ? AppColors.green
                          : AppColors.whiteShadow
                      : AppColors.whiteShadow,
                ),
              ),
            ],
          ),
          Spacer(),
          if (hasCompletionStatus)
            Checkbox(
              value: habit.isCompleted,
              activeColor: AppColors.green,
              onChanged: (bool? value) =>
                  context.read<HabitsOverviewBloc>().add(
                        HabitsOverviewCompletionToggled(
                          habit: habit,
                          isCompleted: value!,
                        ),
                      ),
            ),
        ],
      ),
    );
  }
}

class _HabitIcon extends StatelessWidget {
  const _HabitIcon({required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return Icon(
      size: 25,
      (IconData(
        habit.icon,
        fontFamily: 'MaterialIcons',
      )),
    );
  }
}
