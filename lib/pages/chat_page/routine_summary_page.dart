import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haropal/components/appbar/app_bar_with_hamburger.dart';
import 'package:haropal/components/hamburger/hamburger.dart';
import 'package:haropal/pages/chat_page/routine_feedback_page.dart';

import '../../controllers/routine_controller.dart';
import 'chat_page.dart';

class RoutineSummaryPage extends StatelessWidget {
  final routineController = Get.find<RoutineController>();

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
              crossAxisAlignment: CrossAxisAlignment.center,

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

                /// 소모된 칼로리
                Text(
                  "소모된 칼로리",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "422kcal",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF006BE5)
                  ),
                ),


                SizedBox(height: 28),

                /// 운동 시간
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      "00:57:34", //TODO: 백엔드 응답값으로 교체
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: today.exercises
                      .map((ex) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: _infoTag(ex.name),
                  ))
                      .toList(),
                ),

                SizedBox(height: 6),

                Divider(),


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
            onPressed: () {
              routineController.clearRoutine();
              Get.off(ChatPage());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2A66FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              "확인",
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
  Widget _infoTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label",
        style: TextStyle(
          color: Colors.blue.shade800,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}