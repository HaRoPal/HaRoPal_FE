import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> getSpecificWorkout(int logId) async {
  final dio = await getAuthorizedDio();
  final response = await dio.get('https://haropal-be.onrender.com/community/workouts/$logId/');
  return response.data;
}