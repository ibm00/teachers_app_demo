import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/actions_api.dart';
import '../models/actions.dart';

final actionsProvider = ChangeNotifierProvider((ref) => _ActionsProvider());

class _ActionsProvider extends ChangeNotifier {
  List<ActionModel> actions = [];
  bool isThereIsNextPage = false;

  void addItemsToTheList(List<ActionModel> list) {
    list.forEach((element) {
      actions.add(element);
    });
    notifyListeners();
  }

  getDataByPage(String token, int page) async {
    Map<String, Object> data = await ActionsApi.getActions(token, page);
    if (data['data'] != null) {
      addItemsToTheList(data['data'] as List<ActionModel>);
    }
    isThereIsNextPage = (data['isMore?'] ?? false) as bool;
  }
}
