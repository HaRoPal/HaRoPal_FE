import 'package:flutter/material.dart';

class BigExerciseContainer extends StatelessWidget {
  const BigExerciseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xFFF0F0FF),
              borderRadius: BorderRadius.circular(20)
          ),
          width: width,
          height: 225,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "유산소 운동",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 22.5),
                            child: Text(
                              '유산소',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5555CB)
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      '2:45PM 시작',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text("약 54분 소요 예상"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
            bottom: -20,
            right: 20,
            child: Image.asset(
                'assets/images/exercise/running_girl.png',
              width: 175,
            ))
      ],
    );
  }
}
