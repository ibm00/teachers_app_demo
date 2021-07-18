import 'dart:collection';

import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

import '../models/quiz_models.dart';

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
