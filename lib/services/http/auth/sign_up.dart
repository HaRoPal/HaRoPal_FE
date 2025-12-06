import '../../dio/unauthorized_dio.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> signup({
  required String email,
  required String password,
  String? name,
}) async {
  final dio = await getUnauthorizedDio();

  final body = {
    'email': email,
    'password': password,
    if (name != null) 'full_name': name,
  };

  try {
    final response = await dio.post(
      'https://haropal-be.onrender.com/auth/signup',
      data: body,
    );

    //  1) HTTP 200~299 = 통신 자체 성공
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return {
        "success": response.data["success"] ?? false,
        "message": response.data["message"] ?? "알 수 없는 응답",
        "data": response.data,
      };
    }

    // (이론상 Dio가 여기까지 안 내려오긴 함)
    return {
      "success": false,
      "message": "error: ${response.statusCode}",
    };

  } on DioException catch (e) {
    //  2) 400/500 응답은 여기로 들어옴

    final status = e.response?.statusCode;
    final data = e.response?.data;

    if (status != null && status >= 400 && status < 500) {
      return {
        "success": false,
        "message": data?["message"] ?? "요청 오류가 발생했습니다 (4xx)",
        "status": status,
      };
    }

    if (status != null && status >= 500) {
      return {
        "success": false,
        "message": "서버 오류가 발생했습니다 (5xx)",
        "status": status,
      };
    }

    //  네트워크 단절, 타임아웃 등
    return {
      "success": false,
      "message": "네트워크 오류: ${e.type}",
    };

  } catch (e) {
    //  기타 알 수 없는 오류
    return {
      "success": false,
      "message": "알 수 없는 오류: $e",
    };
  }
}