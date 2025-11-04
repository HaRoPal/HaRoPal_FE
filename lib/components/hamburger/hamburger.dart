import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/chat_page/chat_page.dart';
import '../../pages/community_page/community_page.dart';
import '../../pages/personal_page/personal_page.dart';
import 'components/hamburger_list_tile.dart';

class Hamburger extends StatelessWidget {
  const Hamburger({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 10.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: Image.asset('assets/images/ai/AI_Coach.png'),
              onTap: () {
                Get.back();
                Get.off(() => ChatPage());
              },
            ),
            HamburgerListTile(
              listTileText: '개인 정보',
              listTileIcon: Icons.person_outline,
              onPressed: () {
                Get.back();
                Get.off(() => PersonalPage());
                }),
            HamburgerListTile(
              listTileText: '커뮤니티',
              listTileIcon: Icons.explore_outlined,
              onPressed: () {
                Get.back();
                Get.off(() => CommunityPage());
              },),
            HamburgerListTile(listTileText: '통계', listTileIcon: Icons.pie_chart_outline, onPressed: () {  },),
          ],
        ),
      ),
    );
  }
}
