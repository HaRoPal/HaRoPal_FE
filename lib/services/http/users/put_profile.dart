

import '../../dio/authorized_dio.dart';

Future<bool> putProfile({
  required int age,
  required String gender,
  required int height,
  required int weight,
  required int bmi,
  required int bmr,
  required int muscle,
  required int fat,
  required int desired_exercise_time,
}) async {
  final dio = await getAuthorizedDio();

  String genderEnglish = '';
  if (gender == '남자') {
    genderEnglish = 'male';
  } else {
    genderEnglish = 'female';
  }

  final body = {
    'age': age,
    'gender': genderEnglish,
    'height': height,
    'weight': weight,
    'bmi': bmi,
    'bmr': bmr,
    'muscle': muscle,
    'fat': fat,
    'desired_exercise_time': desired_exercise_time,
  };
  final response = await dio.put(
    'https://haropal-be.onrender.com/users/me/profile',
    data: body,
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}