import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haropal/pages/input_information_page/input_information_page.dart';
import 'package:haropal/services/http/auth/sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = "";
  String password = "";

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
        title: const Text("로그인"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
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
              decoration: const InputDecoration(labelText: "비밀번호"),
              obscureText: true,
              onChanged: (v) => setState(() => password = v),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isFormValid ? () async {
                  final result = await signIn(email: email, password: password);
                  if(result["success"] == true) {
                    Get.snackbar('로그인 성공', '로그인에 성공하였습니다');
                    Get.offAll(() => InputInformationPage());
                  }
                  else{
                    Get.snackbar('오류', '로그인에 실패하였습니다');
                  }
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  disabledBackgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.white,
                ),
                child: const Text("로그인"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}