import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';
import '../../services/chat/Ai_chat.dart';

import '../../components/appbar/app_bar_with_hamburger.dart';
import '../../components/hamburger/hamburger.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = ChatMessagesController();
  final _currentUser = ChatUser(id: 'user', firstName: '사용자 이름');
  final _aiUser = ChatUser(id: 'ai', firstName: 'Gymini');
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithHamburger(),
      drawer: Hamburger(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
        child: AiChatWidget(
          currentUser: _currentUser,
          aiUser: _aiUser,
          controller: _controller,
          onSendMessage: _handleSendMessage,

          loadingConfig: LoadingConfig(isLoading: _isLoading),
          inputOptions: InputOptions(
            sendOnEnter: true,
          ),

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
              ]
            )
          ),

          exampleQuestions: [
            ExampleQuestion(question: "주간 루틴 추천받기"),
            ExampleQuestion(question: "어떻게 시작해야 할 지\n모르겠어요"),
          ],

          messageOptions: MessageOptions(
            bubbleStyle: BubbleStyle(
              userBubbleColor: Colors.white,
              aiBubbleColor: Color(0xFFF2F4F5),
            )
          ),
        ),
      ),
    );
  }

  Future<void> _handleSendMessage(ChatMessage message) async {
    _controller.addMessage(message);
    setState(() => _isLoading = true);

    try {
      // 최근 3개 유저 메시지만 history
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

      // ----------------------------------------------------------------------------------
      // CASE 1 — 루틴 생성 (routine: List 형태)
      // ----------------------------------------------------------------------------------
      if (routineRaw is List) {

        routineController
        final buffer = StringBuffer();
        buffer.writeln("🔥 생성된 운동 루틴입니다!\n");

        for (var dayRoutine in routineRaw) {
          if (dayRoutine is! Map) continue;

          final day = dayRoutine["day"] ?? "Day ?";
          final focus = dayRoutine["focus"] ?? "";
          final exercises = dayRoutine["exercises"] ?? [];

          buffer.writeln("📅 $day");
          buffer.writeln("📌 집중: $focus");
          buffer.writeln("운동 목록:");

          if (exercises is List) {
            for (var ex in exercises) {
              if (ex is! Map) continue;

              buffer.writeln("• ${ex["name"] ?? "이름 없음"}");
              buffer.writeln("  - 세트: ${ex["sets"] ?? "-"}");
              buffer.writeln("  - 반복: ${ex["reps"] ?? "-"}");
              buffer.writeln("  - 휴식: ${ex["rest"] ?? "-"}");
              buffer.writeln("  - 설명: ${ex["description"] ?? ""}");
              buffer.writeln("");
            }
          }

          buffer.writeln("----------------------------------\n");
        }

        // notes, kcal 도 붙여주자
        final notes = response["notes"];
        final kcal = response["expected_kcal"];

        if (notes != null) {
          buffer.writeln("📝 노트:\n$notes\n");
        }

        if (kcal != null) {
          buffer.writeln("🔥 예상 소모 칼로리: $kcal kcal");
        }

        finalText = buffer.toString();
      }

      // ----------------------------------------------------------------------------------
      // CASE 2 — 일반 메시지
      // ----------------------------------------------------------------------------------
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