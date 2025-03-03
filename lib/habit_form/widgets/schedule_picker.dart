import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';
import '../bloc/habit_form_bloc.dart';

class SchedulePicker extends StatelessWidget {
  const SchedulePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Schedule',
          style: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _StartDateTimePicker(),
        const SizedBox(height: AppSpacing.lg),
        _EndDateTimePicker(),
      ],
    );
  }
}

class _StartDateTimePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = context.select((HabitFormBloc bloc) => bloc.state.color);
    final date = context.select((HabitFormBloc bloc) => bloc.state.startDate);
    return ElevatedButton(
      onPressed: () async {
        final pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(2100),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          builder: (context, child) {
            return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: color,
                  ),
                ),
                child: child!);
          },
        );

        if (pickedDate != null && context.mounted) {
          context.read<HabitFormBloc>().add(HabitStartDateChanged(pickedDate));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Start'),
          Text(
            DateFormat('MMM d yyyy').format(date),
            style: TextStyle(
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _EndDateTimePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = context.select((HabitFormBloc bloc) => bloc.state.color);
    final date = context.select((HabitFormBloc bloc) => bloc.state.endDate);
    return ElevatedButton(
      onPressed: () async {
        final pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(2100),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          builder: (context, child) {
            return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: color,
                  ),
                ),
                child: child!);
          },
        );

        if (pickedDate != null && context.mounted) {
          context.read<HabitFormBloc>().add(HabitEndDateChanged(pickedDate));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('End'),
          Text(
            date != null ? DateFormat('MMM d yyyy').format(date) : 'Never',
            style: TextStyle(
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
