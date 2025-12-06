import '../../dio/authorized_dio.dart';

Future<Map<String, dynamic>> getWorkoutDates() async {
  final dio = await getAuthorizedDio();
  final response = await dio.get(
      'https://haropal-be.onrender.com/users/workouts/dates/',
    queryParameters: {
        "year": DateTime.now().year.toString(),
        "month": DateTime.now().month.toString()
    }
  );
  return response.data;
}