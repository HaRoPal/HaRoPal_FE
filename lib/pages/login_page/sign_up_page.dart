import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haropal/services/http/auth/sign_up.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email = "";
  String password = "";
  String name = "";

  final Color primaryBlue = const Color(0xFF0070F0);

  bool get isEmailValid {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  bool get isPasswordValid => password.length >= 6;

  bool get isFormValid => isEmailValid && isPasswordValid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("회원가입"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "이메일"),
              onChanged: (v) => setState(() => email = v),
            ),
            const SizedBox(height: 16),

            TextField(
              decoration: const InputDecoration(labelText: "비밀번호 (6자리 이상)"),
              obscureText: true,
              onChanged: (v) => setState(() => password = v),
            ),
            const SizedBox(height: 16),

            TextField(
              decoration: const InputDecoration(labelText: "사용자 이름 (선택)"),
              onChanged: (v) => setState(() => name = v),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isFormValid ? () async {
                  final result = await signup(email: email, password: password, name: name == "" ? null : name);
                  if (result["success"]) {
                    Get.snackbar('성공', '회원가입에 성공하였습니다');
                    Get.back();
                  }
                  else {
                    Get.snackbar('오류', '회원가입에 실패하였습니다');
                  }
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  disabledBackgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.white,
                ),
                child: const Text("회원가입"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}