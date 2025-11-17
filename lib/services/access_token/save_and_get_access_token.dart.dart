import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<void> saveAccessToken(String? token) async {await secureStorage.write(key: "access_token", value: token);}

Future<String?> getAccessToken() async {return await secureStorage.read(key: "access_token");}