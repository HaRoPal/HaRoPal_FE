import 'package:flutter/material.dart';

class BottomNavigationBarButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;

  const BottomNavigationBarButton({super.key, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: SizedBox(
        height: 55,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0070F0),
            foregroundColor: Colors.white,
          ),
          child: Text(
            buttonName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
