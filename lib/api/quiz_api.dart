import 'dart:collection';

import 'package:http/http.dart' as http;
import 'package:teachers_app/constants.dart';
import 'dart:convert';

import 'package:teachers_app/models/quiz_models.dart';

class QuizApi {
  static Future<List> getCurrentQuizes(String token) async {
    final http.Response response = await http.get(
        Uri.parse('$APP_API/api/quizes/'),
        headers: {'Authorization': 'Token $token'});

    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    } else {
      throw Exception();
    }
  }
}
