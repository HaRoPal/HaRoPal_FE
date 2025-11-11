import 'package:flutter/material.dart';

class AppBarWithHamburger extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWithHamburger({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu)
          )
      ),
      elevation: 2.0,
      shadowColor: Colors.grey[500],
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
    );
  }
}