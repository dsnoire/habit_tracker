import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/habits_overview/bloc/habits_overview_bloc.dart';
import 'package:intl/intl.dart';

import '../../app/colors/app_colors.dart';
import '../../app/spacing/app_spacing.dart';

class HorizontalDatePicker extends StatefulWidget {
  const HorizontalDatePicker({super.key});

  @override
  State<HorizontalDatePicker> createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  late ScrollController _scrollController;
  late DateTime now;
  late int daysInMonth;
  late List<DateTime> dates;
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    dates = List.generate(
      daysInMonth,
      (index) => DateTime(
        now.year,
        now.month,
        index + 1,
        now.hour,
        now.minute,
        now.second,
        now.millisecond,
        now.microsecond,
      ),
    );

    selectedIndex = dates.indexWhere((date) => date.day == now.day);
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDay();
    });

    final weekday = DateFormat('EEEE').format(now);

    context
        .read<HabitsOverviewBloc>()
        .add(HabitsOverviewByDateRequested(weekday, now));
  }

  void _scrollToSelectedDay() {
    double offset = selectedIndex * 56.0;
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = index == selectedIndex;
          final isToday = now.day == date.day;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              final selectedWeekday =
                  DateFormat('EEEE').format(date); // "Monday", "Tuesday", etc.

              log("Selected Day: $selectedWeekday");
              log('$date');
              context
                  .read<HabitsOverviewBloc>()
                  .add(HabitsOverviewByDateRequested(
                    selectedWeekday,
                    date,
                  ));
            },
            child: Container(
              width: 50,
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.surfaceGrey : AppColors.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(date), // Day name  (Mon, Tue)
                    style: TextStyle(
                      fontSize: 12,
                      color: isToday ? AppColors.white : AppColors.grey,
                      fontWeight: isToday ? FontWeight.w500 : FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    '${date.day}', // Day of the month (1, 2, 3)
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
