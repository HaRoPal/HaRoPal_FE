import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haropal/pages/chat_page/routine_summary_page.dart';
import '../../components/appbar/app_bar_with_hamburger.dart';
import '../../components/hamburger/hamburger.dart';
import '../../controllers/routine_controller.dart';
import '../../controllers/today_routine_controller.dart';
import '../../services/http/routine/submit_routine_rating.dart';
import 'chat_page.dart';

class RoutineFeedbackPage extends StatefulWidget {
  final int dayNumber;

  const RoutineFeedbackPage({super.key, required this.dayNumber});

  @override
  State<RoutineFeedbackPage> createState() => _RoutineFeedbackPageState();
}

class _RoutineFeedbackPageState extends State<RoutineFeedbackPage> {
  final routineController = Get.find<RoutineController>();
  final todayController = Get.find<TodayRoutineController>();

  late List<int> ratings;
  int _routineSatisfaction = 0;

  @override
  void initState() {
    super.initState();

    final todayExercises =
        routineController.routines[widget.dayNumber - 1].exercises;

    ratings = List.generate(todayExercises.length, (_) => 0);
  }

  @override
  Widget build(BuildContext context) {
    final finishRes = todayController.finalResponse.value;

    final totalSeconds = finishRes?["totalTime"] ?? 0;
    final timeFormatted = formatSeconds(totalSeconds);

    final todayExercises =
        routineController.routines[widget.dayNumber - 1].exercises;

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
                Text(
                  "운동 난이도 평가",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006BE5),
                  ),
                ),
                const SizedBox(height: 12),

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
                    const Text("•", style: TextStyle(color: Colors.grey)),
                    const SizedBox(width: 8),

                    Text(
                      timeFormatted,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                /// 운동별 난이도
                ListView.builder(
                  itemCount: todayExercises.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final ex = todayExercises[index];

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == todayExercises.length - 1 ? 32 : 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ex.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),

                          /// Dropdown → 별점 UI로 교체했지만 데이터 로직 동일
                          Row(
                            children: List.generate(5, (i) {
                              final filled = i < ratings[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ratings[index] = i + 1;
                                  });
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
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const Divider(thickness: 0.7),
                const SizedBox(height: 20),

                /// 전체 만족도
                const Text(
                  "루틴 전체 만족도",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006BE5),
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: List.generate(5, (i) {
                    final filled = i < _routineSatisfaction;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _routineSatisfaction = i + 1;
                        });
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
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await submitRoutineRatings();
              // TODO: 백엔드에서 소모된 칼로리 계산해주면 summary page로 라우팅 변경
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
              "평가 제출",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitRoutineRatings() async {
    final day = widget.dayNumber;
    final todayExercises =
        routineController.routines[day - 1].exercises;

    final todayMappings = routineController.exerciseMappings
        .where((m) => m.dayNumber == day)
        .toList();

    List<Map<String, dynamic>> exerciseRatingBody = [];

    for (int i = 0; i < todayExercises.length; i++) {
      final ex = todayExercises[i];

      final mapping = todayMappings.firstWhere(
            (m) => m.exerciseName == ex.name,
        orElse: () => throw Exception("exercise mapping not found!"),
      );

      exerciseRatingBody.add({
        "exercise_id": mapping.exerciseId,
        "rating": ratings[i],
      });
    }

    print("⭐ 최종 보내는 exercise_ratings:");
    print(exerciseRatingBody);

    // ⭐ 실제 만족도 값 채워서 API 호출
    await submitRoutineRating(
      workoutLogId: routineController.workoutLogId.value!,
      routineSatisfaction: _routineSatisfaction,
      exerciseRatings: exerciseRatingBody,
      kcal: 0,
    );

    Get.snackbar("완료", "평가가 저장되었습니다!");
  }

  String formatSeconds(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return "$m분 $s초";
  }
}