import 'package:flutter/material.dart';

class ExerciseContainer extends StatelessWidget {
  const ExerciseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: 300,
        height: 185,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              spreadRadius: 2,
              blurRadius: 6,
            )
          ],
        ),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                  "User1",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF72777A),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text('173cm · 72kg'),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                            "소모된 칼로리",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                              '217kcal',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFF0070F0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/exercise/muscle.png',
                                width: 25,
                              ),
                              Image.asset(
                                'assets/images/exercise/push_up.png',
                                width: 25,
                              ),
                              Image.asset(
                                'assets/images/exercise/sit_up.png',
                                width: 25,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text("시간 · 00:42:34"),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                            '체감 만족도',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 6),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 17.5,),
                              Icon(Icons.star, color: Colors.amber, size: 17.5,),
                              Icon(Icons.star, color: Colors.amber, size: 17.5,),
                              Icon(Icons.star_border, size: 17.5,),
                              Icon(Icons.star_border, size: 17.5,),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
