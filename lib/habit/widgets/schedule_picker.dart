import 'package:flutter/material.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';

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
    return ElevatedButton(
      onPressed: () async {
        final pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(2100),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
        );

        if (pickedDate != null) {
          /// todo: bloc method
          print(pickedDate);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Start'),
          Text(
            '1 February',
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
    return ElevatedButton(
      onPressed: () async {
        final pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(2100),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
        );

        if (pickedDate != null) {
          /// todo: bloc method
          print(pickedDate);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('End'),
          Text(
            'Never',
            style: TextStyle(
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
