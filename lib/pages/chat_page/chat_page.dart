import 'package:flutter/material.dart';

import '../../components/appbar/app_bar_with_hamburger.dart';
import '../../components/hamburger/hamburger.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithHamburger(),
      drawer: Hamburger(),
      body: Center(child: Text('여기는 채팅 공간 입니다')),
    );
  }
}
