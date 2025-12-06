import 'package:flutter/material.dart';

import '../../../helper/filter_category_image.dart';

class ExerciseContainer extends StatelessWidget {
  final String nickname;
  final String category;
  final int kcal;
  final int satisfaction;
  final double height;
  final double weight;
  final String totalTime;
  const ExerciseContainer({super.key,
    required this.kcal,
    required this.nickname,
    required this.category,
    required this.satisfaction,
    required this.height,
    required this.weight,
    required this.totalTime
  });

  @override
  Widget build(BuildContext context) {
    final imagePath = filterCategoryImage[category];
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
                        Padding(
                          padding: const EdgeInsets.only(top: 7.5),
                          child: Text(
                              nickname,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF72777A),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text('${height}cm · ${weight}kg'),
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
                              '${kcal}kcal',
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
                        Image.asset(
                          imagePath ?? 'assets/images/exercise/가슴.png',
                          width: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text("시간 · $totalTime"),
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
                              Row(
                                children: List.generate(
                                  satisfaction,
                                    (index) {
                                      return Icon(Icons.star, color: Colors.amber, size: 17.5,);
                                    }
                                )
                              ),
                              Row(
                                  children: List.generate(
                                      5 - satisfaction,
                                          (index) {
                                        return Icon(Icons.star_border, size: 17.5,);
                                      }
                                  )
                              ),
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
