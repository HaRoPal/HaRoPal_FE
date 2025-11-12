import 'package:flutter/material.dart';
import 'package:streak_calendar/streak_calendar.dart';

class StreakCalendar extends StatelessWidget {
  const StreakCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: CleanCalendar(
        headerProperties: HeaderProperties(
          navigatorDecoration: NavigatorDecoration(
            navigateLeftButtonIcon: const Icon(
              Icons.access_time,
              color: Colors.white,
            ),
            navigateRightButtonIcon: const Icon(
              Icons.access_time,
              color: Colors.white,
            ),
          )
        ),
        leadingTrailingDatesProperties: DatesProperties(
          disable: true,
          hide: true,
        ),
        generalDatesProperties: DatesProperties(
          datesDecoration: DatesDecoration(
            datesBorderRadius: 1000,
            datesBackgroundColor: Colors.lightGreen.shade100,
            datesBorderColor: Colors.lightGreen.shade100,
          )
        ),
        streakDatesProperties: DatesProperties(
          datesDecoration: DatesDecoration(
            datesBorderRadius: 1000,
            datesBorderColor: Colors.green,
            datesBackgroundColor: Colors.green,
            datesTextColor: Colors.white,
          )
        ),
        datesForStreaks: [
          DateTime(2025, 11, 3),
          DateTime(2025, 11, 5),
          DateTime(2025, 11, 8),
          DateTime(2025, 11, 9),
          DateTime(2025, 11, 10),
          DateTime(2025, 11, 11),
          DateTime(2025, 11, 12),
        ],
      ),
    );
  }
}
