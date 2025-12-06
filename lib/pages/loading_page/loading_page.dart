import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "데이터를 불러오고 있습니다...",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: LinearProgressIndicator(
                  color: Color(0xFF0070F0),
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
