import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:haropal/pages/login_page/splash_page.dart';

import 'init_controllers.dart';
import 'pages/login_page/start_page.dart';

Future<void> main() async {
  initControllers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}