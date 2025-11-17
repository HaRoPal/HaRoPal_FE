import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/appbar/app_bar_with_title_and_hamburger.dart';
import '../../components/hamburger/hamburger.dart';
import '../../controllers/community_controller.dart';
import 'components/category_container.dart';
import 'components/exercise_container.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final controller = Get.find<CommunityController>();

  @override
  void initState() {
    super.initState();
    controller.fetchSimilar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithTitleAndHamburger(title: '커뮤니티'),
      drawer: Hamburger(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 40),
                child: Text(
                    '커뮤니티',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  '최근에 완료한 운동',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          ExerciseContainer(),
                          ExerciseContainer(),
                        ],
                      ),
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 0, 0),
                child: Text(
                  '내 체형과 비슷한 운동',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          ExerciseContainer(),
                          ExerciseContainer(),
                        ],
                      ),
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                    "운동별 보기",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
              ),
              CategoryContainer(
                categoryName: '팔굽혀펴기',
                categoryImagePath: 'assets/images/exercise/push_up.png'
              ),
              CategoryContainer(
                  categoryName: '윗몸 일으키기',
                  categoryImagePath: 'assets/images/exercise/sit_up.png'
              ),
              CategoryContainer(
                  categoryName: '이두컬',
                  categoryImagePath: 'assets/images/exercise/muscle.png'
              ),
              CategoryContainer(
                  categoryName: '덤벨프레스',
                  categoryImagePath: 'assets/images/exercise/weightlifting.png'
              ),
              CategoryContainer(
                  categoryName: '해머컬',
                  categoryImagePath: 'assets/images/exercise/dumbell.png'
              ),
            ],
          ),
        ),
      ),
    );
  }
}
