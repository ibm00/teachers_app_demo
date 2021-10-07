// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/actions.dart';

class ActionsApi {
  static Future<Map<String, Object>> getActions(String token, int page) async {
    try {
      http.Response res = await http.get(
          Uri.parse('$APP_API/api/actions/?page=$page'),
          headers: <String, String>{
            'Authorization': 'Token $token',
            //   "Content-Type": "application/json",
          });
      Map data = json.decode(utf8.decode(res.bodyBytes)) as Map;
      List unParsedActions = data['results'] as List;
      List<ActionModel> actions = [];
      unParsedActions.forEach((element) {
        actions.add(ActionModel.fromMap(element as Map));
      });
      return {'data': actions, 'isMore?': data['next'] != null};
    } catch (e) {
      print(e);
      //showCustomToast('حدثت مشكلة الرجاء المحاولة لاحقا');
      return {};
    }
  }
}
