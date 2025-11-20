import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/appbar/app_bar_with_title_and_hamburger.dart';
import '../../components/hamburger/hamburger.dart';
import '../../controllers/community_controller.dart';
import '../../controllers/specific_page_controller.dart';
import '../loading_page/loading_page.dart';
import '../specific_statistics_page/specific_statistics_page.dart';
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
    controller.fetchData();
  }

  @override
  void dispose() {
    controller.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.value
          ? LoadingPage() :
      Scaffold(
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
                            children: List.generate(
                                controller.totalRecentWorkout.length,
                                    (index) {
                                  final item = controller.totalRecentWorkout[index];
                                  return GestureDetector(
                                    onTap: () {
                                      final specificController = Get.find<SpecificPageController>();
                                      specificController.logId.value = item['id'];
                                      specificController.fetchSpecificWorkout();
                                      Get.to(() => SpecificStatisticsPage());
                                    },
                                    child: ExerciseContainer(
                                      nickname: item['nickname'],
                                      category: item['category'],
                                      kcal: item['kcal'],
                                      satisfaction: item['satisfaction'],
                                      height: item['height'],
                                      weight: item['weight'],
                                      totalTime: item['totalTime'],
                                    ),
                                  );
                                }
                            )
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
                          child: Obx(() {
                            return Row(
                              children: List.generate(
                                  controller.totalRecommendedWorkout.length,
                                      (index) {
                                    final item = controller.totalRecommendedWorkout[index];
                                    return ExerciseContainer(
                                      nickname: item['nickname'],
                                      category: item['category'],
                                      kcal: item['kcal'],
                                      satisfaction: item['satisfaction'],
                                      height: item['height'],
                                      weight: item['weight'],
                                      totalTime: item['totalTime'],
                                    );
                                  }
                              ),
                            );
                          })
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
                    categoryName: '가슴',
                    categoryImagePath: 'assets/images/exercise/가슴.png'
                ),
                CategoryContainer(
                    categoryName: '어깨',
                    categoryImagePath: 'assets/images/exercise/어깨.png'
                ),
                CategoryContainer(
                    categoryName: '팔',
                    categoryImagePath: 'assets/images/exercise/팔.png'
                ),
                CategoryContainer(
                    categoryName: '다리',
                    categoryImagePath: 'assets/images/exercise/다리.png'
                ),
                CategoryContainer(
                    categoryName: '복근',
                    categoryImagePath: 'assets/images/exercise/복근.png'
                ),
                CategoryContainer(
                    categoryName: '유산소',
                    categoryImagePath: 'assets/images/exercise/유산소.png'
                ),
                CategoryContainer(
                    categoryName: '등',
                    categoryImagePath: 'assets/images/exercise/등.png'
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
