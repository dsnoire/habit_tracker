import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/extensions/extensions.dart';

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
        _DateTimePicker(
          label: 'Start',
          dateSelector: (bloc) => bloc.state.startDate,
          onDateChanged: (date) =>
              context.read<HabitFormBloc>().add(HabitStartDateChanged(date)),
        ),
        const SizedBox(height: AppSpacing.lg),
        _DateTimePicker(
          label: 'End',
          dateSelector: (bloc) => bloc.state.endDate,
          onDateChanged: (date) =>
              context.read<HabitFormBloc>().add(HabitEndDateChanged(date)),
          defaultText: 'Never',
        ),
      ],
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    required this.label,
    required this.dateSelector,
    required this.onDateChanged,
    this.defaultText,
  });

  final String label;
  final DateTime? Function(HabitFormBloc bloc) dateSelector;
  final void Function(DateTime date) onDateChanged;
  final String? defaultText;

  @override
  Widget build(BuildContext context) {
    final color = context.select((HabitFormBloc bloc) => bloc.state.color);
    final date = context.select(dateSelector);

    return ElevatedButton(
      onPressed: () async {
        final currentDate = DateTime.now().add(Duration(days: 0));
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: currentDate,
          lastDate: DateTime(2100),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.dark(primary: color),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null && context.mounted) {
          onDateChanged(pickedDate);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            date?.monthDayYear ?? defaultText ?? '',
            style: TextStyle(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
