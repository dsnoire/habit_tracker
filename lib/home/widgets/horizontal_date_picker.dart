import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../app/colors/app_colors.dart';

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
      ),
    );

    selectedIndex = dates.indexWhere((date) => date.day == now.day);
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDay();
    });
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
    return Container(
      margin: EdgeInsets.only(top: 16),
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
              print("Selected: ${date.day}");
            },
            child: Container(
              width: 50,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.surfaceGrey : AppColors.background,
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
                  SizedBox(height: 4),
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
