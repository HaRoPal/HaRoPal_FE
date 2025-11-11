import 'package:flutter/material.dart';

import '../../components/appbar/app_bar_with_title_and_hamburger.dart';
import '../../components/hamburger/hamburger.dart';
import 'components/big_exercise_container.dart';
import 'components/latest_exercise.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithTitleAndHamburger(title: '통계'),
      drawer: Hamburger(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                    "통계",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Text(
                    "Gymini 추천 활동",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: BigExerciseContainer(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
                child: Text(
                    '지난 운동 기록',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: Row(
                  children: [
                    Icon(Icons.explore_outlined, color: Color(0xFF73787B),),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                          '5개의 기록',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.5,
                          color: Color(0xFF73787B)
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        LatestExercise(),
                        LatestExercise(),
                        LatestExercise(),
                        LatestExercise(),
                        LatestExercise(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                  child: Center(child: Text("여기에는 그래프가 들어갑니다")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
