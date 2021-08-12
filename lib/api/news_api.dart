import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/news_model.dart';

import '../constants.dart';

class NewsApi {
  static Future<Map<String, Object>> getNews(String token, int page) async {
    try {
      http.Response res = await http.get(
          Uri.parse('$APP_API/api/news/?page=$page'),
          headers: <String, String>{
            'Authorization': 'Token $token',
            //   "Content-Type": "application/json",
          });
      Map data = json.decode(utf8.decode(res.bodyBytes)) as Map;
      List unParsedActions = data['results'] as List;
      List<NewsModel> news = [];
      unParsedActions.forEach((element) {
        news.add(NewsModel.fromMap(element as Map));
      });
      return {'data': news, 'isMore?': data['next'] != null};
    } catch (e) {
      print(e);
      //showCustomToast('حدثت مشكلة الرجاء المحاولة لاحقا');
      return {};
    }
  }
}
