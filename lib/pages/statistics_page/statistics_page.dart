import 'package:flutter/material.dart';

import '../../components/appbar/app_bar_with_title_and_hamburger.dart';
import '../../components/hamburger/hamburger.dart';
import 'components/exercise_graph.dart';
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
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width - 20,
                  child: ExerciseGraph(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
