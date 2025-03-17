import 'package:database_client/database_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          backgroundColor: AppColors.background,
          builder: (modalContext) {
            return BlocProvider.value(
              value: BlocProvider.of<HabitsOverviewBloc>(context),
              child: _HabitBottomSheet(habit: habit),
            );
          },
        );
      },
      child: Container(
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
      ),
    );
  }
}

class _HabitBottomSheet extends StatelessWidget {
  const _HabitBottomSheet({required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            spacing: AppSpacing.lg,
            children: [
              Text(
                '${habit.name} habit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListTile(
                onTap: () {
                  context.pop();
                  context.push(
                    '/edit-habit',
                    extra: habit,
                  );
                },
                tileColor: AppColors.surfaceGrey,
                shape: StadiumBorder(),
                leading: Icon(
                  Icons.edit,
                  color: AppColors.white,
                ),
                title: Text('Edit'),
              ),
              BlocListener<HabitsOverviewBloc, HabitsOverviewState>(
                listener: (context, state) {
                  if (state.status == HabitsOverviewStatus.success) {
                    context.pop();
                  }
                },
                child: ListTile(
                  onTap: () {
                    context.read<HabitsOverviewBloc>().add(
                          HabitsOverviewHabitDeleted(habit),
                        );
                  },
                  tileColor: AppColors.surfaceGrey,
                  shape: StadiumBorder(),
                  leading: Icon(
                    Icons.delete,
                    color: AppColors.red,
                  ),
                  title: Text('Delete'),
                ),
              ),
            ],
          ),
        ),
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
