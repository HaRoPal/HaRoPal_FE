import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> getRecentWorkout() async {
  final dio = await getAuthorizedDio();
  final response = await dio.get(
      'https://haropal-be.onrender.com/users/workouts/recent/');
  return response.data;
}
