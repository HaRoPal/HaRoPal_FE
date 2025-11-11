import 'package:flutter/material.dart';

class HamburgerListTile extends StatelessWidget {
  final String listTileText;
  final IconData listTileIcon;
  final VoidCallback onPressed;
  const HamburgerListTile({super.key, required this.listTileText, required this.listTileIcon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(listTileIcon),
            ),
            Text(
              listTileText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
