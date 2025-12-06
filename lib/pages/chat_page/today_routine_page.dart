import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haropal/components/appbar/app_bar_with_hamburger.dart';
import 'package:haropal/components/hamburger/hamburger.dart';
import 'package:haropal/pages/chat_page/routine_feedback_page.dart';

import '../../controllers/routine_controller.dart';

import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../controllers/today_routine_controller.dart';

class TodayRoutinePage extends StatelessWidget {
  final routineController = Get.find<RoutineController>();
  final todayController = Get.put(TodayRoutineController());

  @override
  Widget build(BuildContext context) {
    final today = routineController.todayRoutine;

    if (today == null) {
      return Scaffold(
        appBar: AppBarWithHamburger(),
        body: Center(child: Text("저장된 루틴이 없습니다.")),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBarWithHamburger(),
      drawer: Hamburger(),

      /// -----------------------------
      /// 1) 본문: 스크롤 가능
      /// -----------------------------
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          color: Color(0xFFF2F8FF),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 상단 제목
                Text(
                  "오늘의 운동 루틴",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006BE5)
                  ),
                ),
                SizedBox(height: 12),

                // 타이머 UI
                StreamBuilder<int>(
                  stream: todayController.timer.rawTime,
                  initialData: 0,
                  builder: (context, snap) {
                    final value = snap.data ?? 0;
                    final displayTime = StopWatchTimer.getDisplayTime(value);
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        displayTime,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF006BE5),
                        ),
                      ),
                    );
                  },
                ),

                /// 집중 분야
                Text(
                  "집중 분야: ${today.focus}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 20),
                Divider(),

                /// 운동 리스트
                ...today.exercises.map((ex) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 운동 이름
                        Text(
                          ex.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 8),

                        /// 세트/반복/휴식 태그
                        Wrap(
                          spacing: 8,        // 요소 간 가로 간격
                          runSpacing: 6,     // 줄바뀔 때 세로 간격
                          children: [
                            _infoTag("세트", "${ex.sets}"),
                            _infoTag("반복", ex.reps),
                            _infoTag("휴식", ex.rest),
                          ],
                        ),

                        SizedBox(height: 12),

                        /// 설명
                        Text(
                          ex.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),

      /// -----------------------------
      /// 2) 운동 종료 버튼
      /// -----------------------------
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 24),
        color: Colors.transparent,
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await todayController.finishRoutineAndSend();
              final response = todayController.finalResponse.value;
              if (response != null){
                final index = routineController.routines.indexWhere((r) => r.day == today.day);
                final dayNumber = index + 1;
                routineController.todayDayNumber.value = dayNumber;
                Get.to(RoutineFeedbackPage(dayNumber: dayNumber));
              }
              else{
                Get.snackbar('오류', '운동을 종료하지 못했습니다');
              }

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2A66FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              "운동 종료",
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

  /// -------------------------
  /// 세트/반복/휴식 태그 UI 재사용 코드
  /// -------------------------
  Widget _infoTag(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label: $value",
        style: TextStyle(
          color: Colors.blue.shade800,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}