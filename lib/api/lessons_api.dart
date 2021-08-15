import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';

class LessonsApi {
  static Future<List?>? getChapters(String token) async {
    final http.Response res = await http.get(
      Uri.parse(
        '$APP_API/api/chapters',
      ),
      headers: {'Authorization': 'Token $token'},
    );
    if (res.statusCode == 200) {
      final List data = json.decode(utf8.decode(res.bodyBytes)) as List;
      return data;
    }
  }
}
