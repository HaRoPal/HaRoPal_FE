import 'package:flutter/material.dart';

import '../../components/appbar/app_bar_with_title_and_hamburger.dart';
import '../../components/hamburger/hamburger.dart';
import 'components/personal_information.dart';
import 'components/routine_count.dart';
import 'components/streak_calendar.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const AppBarWithTitleAndHamburger(title: '개인 정보'),
      drawer: const Hamburger(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 36),
          child: Column(
            children: [
              PersonalInformation(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Text(
                        '00일 연속으로 운동 중이에요!🔥',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: StreakCalendar(),
              ),
              RoutineCount(text: '루틴 완료 횟수', count: 20, exp: 000),
              RoutineCount(text: '루틴 연속 완료 횟수', count: 7, exp: 000),
              RoutineCount(text: '기록 공유 횟수', count: 10, exp: 000),
            ],
          ),
        ),
      ),
    );
  }
}
