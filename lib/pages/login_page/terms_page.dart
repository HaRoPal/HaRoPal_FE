import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool agreePersonal = false;
  bool agreeNotice = false;

  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.04),

              // 약관 박스 전체
              Container(
                padding: EdgeInsets.all(size.width * 0.05),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(size.width * 0.02),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gymini 개인정보 수집 및 이용 동의',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),

                    Text(
                      'Gymini 필수 서비스 제공을 위해 개인정보 수집 및 이용 동의를 받고자 합니다. 아래의 내용을 확인하고 동의 여부를 선택해 주세요.',
                      style: TextStyle(fontSize: size.width * 0.035),
                    ),
                    SizedBox(height: size.height * 0.015),

                    Text('• 제3자 제공: 없음'),
                    Text('• 처리위탁: Render - Oregon (US West) 리전'),
                    Text('• 국외 이전: 해당 없음'),
                    Text('• 수집 목적: 운동 루틴 생성·추천, 운동 기록 저장, 개인화된 서비스 제공'),
                    Text('• 수집 항목: 이메일, 이름, 운동 기록(시간/루틴/완료 여부 등)'),
                    Text('• 보유 및 이용 기간: 회원 탈퇴 시 즉시 파기'),
                    SizedBox(height: size.height * 0.015),

                    Text(
                      '* 동의하지 않을 권리가 있으나, 미동의 시 Gymini의 필수 기능 이용에 제한이 있을 수 있습니다.',
                      style: TextStyle(
                        fontSize: size.width * 0.033,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),

                    // 체크박스 1
                    CheckboxListTile(
                      title: Text('(필수) 개인정보 수집 및 이용 동의'),
                      value: agreePersonal,
                      onChanged: (val) {
                        setState(() => agreePersonal = val!);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),

                    // 체크박스 2
                    CheckboxListTile(
                      title: Text('(필수) 서비스 이용 고지사항 확인'),
                      value: agreeNotice,
                      onChanged: (val) {
                        setState(() => agreeNotice = val!);
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),

                    SizedBox(height: size.height * 0.01),
                    Text(
                      '동의서 버전: 1.0',
                      style: TextStyle(fontSize: size.width * 0.03),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // 버튼
              Opacity(
                opacity: (agreePersonal && agreeNotice) ? 1.0 : 0.4,
                child: GestureDetector(
                  onTap: () async {
                    if (agreePersonal && agreeNotice) {
                      await storage.write(key: 'terms_agreed', value: 'true');
                      Get.back(result: true);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    margin: EdgeInsets.only(bottom: size.height * 0.02),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0070F0),
                      borderRadius: BorderRadius.circular(size.width * 0.02),
                    ),
                    child: Text(
                      '동의 완료',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}