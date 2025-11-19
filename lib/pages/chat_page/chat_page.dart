import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import 'package:get/get.dart';
import 'package:haropal/pages/chat_page/today_routine_page.dart';

import '../../services/chat/Ai_chat.dart';
import '../../components/appbar/app_bar_with_hamburger.dart';
import '../../components/hamburger/hamburger.dart';
import '../../controllers/routine_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = ChatMessagesController();
  final _currentUser = ChatUser(id: 'user', firstName: '사용자');
  final _aiUser = ChatUser(id: 'ai', firstName: 'Gymini');
  final routineController = Get.find<RoutineController>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithHamburger(),
      drawer: Hamburger(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // --- 채팅 UI ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: AiChatWidget(
                currentUser: _currentUser,
                aiUser: _aiUser,
                controller: _controller,
                onSendMessage: _handleSendMessage,

                // 로딩
                loadingConfig: LoadingConfig(isLoading: _isLoading),

                // 입력창
                inputOptions: InputOptions(
                  sendOnEnter: true,
                ),

                // 웰컴 메시지 유지
                welcomeMessageConfig: WelcomeMessageConfig(
                  title: 'Gymini에 오신 것을\n환영합니다!',
                  questionsSectionTitle: '이런 것을 물어보세요:',
                  containerDecoration: BoxDecoration(
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
                ),

                exampleQuestions: [
                  ExampleQuestion(question: "주간 루틴 추천받기"),
                  ExampleQuestion(question: "어떻게 시작해야 할 지\n모르겠어요"),
                ],

                // 말풍선 스타일
                messageOptions: MessageOptions(
                  bubbleStyle: BubbleStyle(
                    userBubbleColor: Colors.white,
                    aiBubbleColor: const Color(0xFFF2F4F5),
                  ),
                ),
              ),
            ),
          ),

          // --- 루틴 있는 경우 버튼 표시 ---
          Obx(() {
            final hasRoutine = routineController.routines.isNotEmpty;
            if (!hasRoutine) return const SizedBox.shrink();

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () => Get.to(TodayRoutinePage()),
                  child: const Text(
                    "이 루틴으로 운동 시작",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  // ====================================================================================
  // 메시지 전송 처리
  // ====================================================================================
  Future<void> _handleSendMessage(ChatMessage message) async {
    _controller.addMessage(message);
    setState(() => _isLoading = true);

    try {
      // 최근 3개 유저 메시지만 history로
      final userMessages = _controller.messages
          .where((msg) => msg.user.id == "user" && msg.text.trim().isNotEmpty)
          .toList();

      final history = userMessages
          .skip(userMessages.length > 3 ? userMessages.length - 3 : 0)
          .map((msg) => {"role": "user", "content": msg.text})
          .toList();

      final response = await sendAiMessage(
        message: message.text,
        history: history,
      );

      final routineRaw = response["routine"];
      final messageText = response["message"];
      String finalText = "";

      // ================================================================
      // CASE 1 — 루틴 생성
      // ================================================================
      if (routineRaw is List) {
        routineController.saveRoutine(routineRaw);

        // Day 1 루틴만 가져오기
        final today = routineController.routines.first;

        // 안내 메시지
        _controller.addMessage(ChatMessage(
          text: "오늘의 운동 루틴을 요약해드릴게요!",
          user: _aiUser,
          createdAt: DateTime.now(),
        ));

        // 요약 텍스트 구성
        final buffer = StringBuffer();
        buffer.writeln("📅 ${today.day}");
        buffer.writeln("📌 집중: ${today.focus}");
        buffer.writeln("");
        buffer.writeln("🔥 오늘 할 운동");
        for (var ex in today.exercises) {
          buffer.writeln(
            "• ${ex.name} — ${ex.sets}세트 / ${ex.reps} (${ex.rest} 휴식)",
          );
        }

        _controller.addMessage(ChatMessage(
          text: buffer.toString(),
          user: _aiUser,
          createdAt: DateTime.now(),
        ));

        // 루틴일 때는 밑의 일반 응답 전송 안 함
        return;
      }

      // ================================================================
      // CASE 2 — 일반 응답
      // ================================================================
      else {
        finalText = messageText?.toString() ?? "응답 없음";
      }

      _controller.addMessage(ChatMessage(
        text: finalText,
        user: _aiUser,
        createdAt: DateTime.now(),
      ));
    } catch (e) {
      _controller.addMessage(ChatMessage(
        text: "⚠️ 오류 발생: $e",
        user: _aiUser,
        createdAt: DateTime.now(),
      ));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}