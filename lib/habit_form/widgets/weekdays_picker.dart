import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';
import '../bloc/habit_form_bloc.dart';

class WeekdaysPicker extends StatelessWidget {
  const WeekdaysPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekdays',
          style: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _WeekdayTile(),
      ],
    );
  }
}

class _WeekdayTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = context.select((HabitFormBloc bloc) => bloc.state.color);
    final selectedWeekdays =
        context.select((HabitFormBloc bloc) => bloc.state.weekdays);
    final weekdays = {
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    };

    return Row(
      children: List.generate(
        weekdays.length,
        (index) {
          final weekday = weekdays.elementAt(index);
          final isSelected = selectedWeekdays.contains(weekday);
          return Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<HabitFormBloc>().add(HabitWeekdayToggled(weekday));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? color : AppColors.surfaceGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    weekday.substring(0, 3),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color:
                          isSelected ? AppColors.background : AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
