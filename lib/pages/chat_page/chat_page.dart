import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/flutter_gen_ai_chat_ui.dart';

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
      // Your AI service logic here
      await Future.delayed(Duration(seconds: 1));

      // Add AI response
      _controller.addMessage(ChatMessage(
        text: "This is a response to: ${message.text}",
        user: _aiUser,
        createdAt: DateTime.now(),
      ));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}