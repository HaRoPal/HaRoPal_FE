import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haropal/components/appbar/app_bar_with_hamburger.dart';
import 'package:haropal/components/hamburger/hamburger.dart';
import 'package:haropal/pages/chat_page/chat_page.dart';

import '../../controllers/routine_controller.dart';

class RoutineFeedbackPage extends StatefulWidget {

  const RoutineFeedbackPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RoutineFeedbackPage> createState() => _RoutineFeedbackPageState();
}

class _RoutineFeedbackPageState extends State<RoutineFeedbackPage> {
  final routineController = Get.find<RoutineController>();

  late List<int> _exerciseRatings; // 각 운동별 별점 (0~5)
  int _routineSatisfaction = 0;    // 루틴 전체 만족도 (0~5)

  @override
  void initState() {
    super.initState();
    final today = routineController.todayRoutine;
    // today가 null인 경우를 대비해서 길이 0으로
    final length = today?.exercises.length ?? 0;
    _exerciseRatings = List<int>.filled(length, 0);
  }

  @override
  Widget build(BuildContext context) {
    final today = routineController.todayRoutine;

    if (today == null) {
      return Scaffold(
        appBar: AppBarWithHamburger(),
        body: const Center(child: Text("평가할 루틴이 없습니다.")),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBarWithHamburger(),
      drawer: Hamburger(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: const Color(0xFFF2F8FF),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 상단 제목
                const Text(
                  "운동 난이도 평가",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006BE5),
                  ),
                ),
                const SizedBox(height: 8),

                /// 운동 시간
                Row(
                  children: [
                    const Text(
                      "운동 시간",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "•",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "00:57:34",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// ----- 각 운동별 난이도 별점 -----
                ListView.builder(
                  itemCount: today.exercises.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final ex = today.exercises[index];

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == today.exercises.length - 1 ? 24 : 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _exerciseChip(ex.name),
                          const SizedBox(height: 12),
                          _StarRating(
                            rating: _exerciseRatings[index],
                            onChanged: (value) {
                              setState(() {
                                _exerciseRatings[index] = value;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 8),
                const Divider(thickness: 0.8),
                const SizedBox(height: 16),

                /// ----- 루틴 전체 만족도 -----
                const Text(
                  "루틴 만족도",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF006BE5),
                  ),
                ),
                const SizedBox(height: 16),
                _StarRating(
                  rating: _routineSatisfaction,
                  onChanged: (value) {
                    setState(() {
                      _routineSatisfaction = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      /// 하단 제출 버튼
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        color: Colors.transparent,
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // 별점 값들은 _exerciseRatings, _routineSatisfaction 에 들어 있음
              routineController.clearRoutine();
              Get.off(ChatPage());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A66FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "제출하기",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 운동 이름 칩 (연한 회색 배경 + 라운드)
  Widget _exerciseChip(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}

/// 공통 별점 위젯 (★ x 5)
class _StarRating extends StatelessWidget {
  final int rating; // 0~5
  final ValueChanged<int> onChanged;

  const _StarRating({
    Key? key,
    required this.rating,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(5, (index) {
        final filled = index < rating;
        return GestureDetector(
          onTap: () {
            onChanged(index + 1); // 1~5
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              filled ? Icons.star : Icons.star_border,
              size: 32,
              color: Colors.black87,
            ),
          ),
        );
      }),
    );
  }
}