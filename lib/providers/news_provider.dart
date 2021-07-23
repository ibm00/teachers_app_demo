import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/api/news_api.dart';
import 'package:teachers_app/models/news_model.dart';
import 'package:teachers_app/providers/user_data_provider.dart';
import '../api/actions_api.dart';
import '../models/actions.dart';

final newsFutureProvider = FutureProvider<List<NewsModel>>((ref) async {
  Map data = await NewsApi.getNews(ref.read(userDataProvider).token, 1);
  return data['data'] as List<NewsModel>;
});
final newsProvider = ChangeNotifierProvider((ref) => _NewsProvider());

class _NewsProvider extends ChangeNotifier {
  List<NewsModel> news = [];
  bool isThereIsNextPage = false;

  void addItemsToTheList(List<NewsModel> list) {
    list.forEach((element) {
      news.add(element);
    });
    notifyListeners();
  }

  getDataByPage(String token, int page) async {
    Map<String, Object> data = await NewsApi.getNews(token, page);
    if (data['data'] != null) {
      addItemsToTheList(data['data'] as List<NewsModel>);
    }
    isThereIsNextPage = (data['isMore?'] ?? false) as bool;
  }
}
