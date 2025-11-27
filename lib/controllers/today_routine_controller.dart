import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../services/http/routine/finish_routine.dart';
import 'routine_controller.dart';

class TodayRoutineController extends GetxController {
  // StopWatchTimer 인스턴스
  final StopWatchTimer timer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  final routineController = Get.find<RoutineController>();

  // 현재 경과 시간 (초 또는 ms 필요 시 변환해서 사용)
  final rawTime = 0.obs;

  final finalResponse = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();

    // 타이머 rawTime stream listen
    timer.rawTime.listen((value) {
      rawTime.value = value;
    });

    // 루틴 시작과 동시에 타이머 시작 (원하면 수동으로 변경 가능)
    timer.onStartTimer();
  }

  // 운동 종료 및 서버로 전달할 total_time 계산
  Future<void> finishRoutineAndSend() async {
    timer.onStopTimer();

    // ms → 분 변환
    final totalMinutes = rawTime.value / 1000 / 60;

    final workoutLogId = routineController.workoutLogId.value;
    if (workoutLogId == null) {
      print("❌ workoutLogId 없음");
      return;
    }

    print("👉 total_time(min): $totalMinutes");

    final res = await finishRoutine(
      workoutLogId: workoutLogId,
    );

    print("finish response: $res");

    finalResponse.value = res;
  }

  @override
  void onClose() async {
    await timer.dispose();
    super.onClose();
  }

  void onClear() {
    // 1) 타이머 초기화
    timer.onStopTimer();
    timer.onResetTimer();

    // 2) rawTime 초기화
    rawTime.value = 0;

    // 3) 서버 응답값 초기화
    finalResponse.value = null;

  }
}