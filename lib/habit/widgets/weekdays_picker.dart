import 'package:flutter/material.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';

final Map<String, bool> weekdays = {
  'Monday': false,
  'Tuesday': false,
  'Wednesday': false,
  'Thursday': false,
  'Friday': false,
  'Saturday': false,
  'Sunday': false,
};

class WeekdaysPicker extends StatefulWidget {
  const WeekdaysPicker({super.key});

  @override
  State<WeekdaysPicker> createState() => _WeekdaysPickerState();
}

class _WeekdaysPickerState extends State<WeekdaysPicker> {
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
        Row(
          children: List.generate(
            weekdays.length,
            (index) {
              final isSelected = weekdays.values.elementAt(index);
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        weekdays.update(
                          weekdays.keys.elementAt(index),
                          (value) {
                            return !value;
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.white : AppColors.surfaceGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        (weekdays.keys.elementAt(index)).substring(0, 3),
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? AppColors.darkGrey : AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
