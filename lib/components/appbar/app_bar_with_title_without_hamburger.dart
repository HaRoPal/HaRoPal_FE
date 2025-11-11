import 'package:flutter/material.dart';

class AppBarWithTitleWithoutHamburger extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWithTitleWithoutHamburger({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 2.0,
      shadowColor: Colors.grey[500],
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    );
  }
}