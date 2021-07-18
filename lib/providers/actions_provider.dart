import 'package:flutter/material.dart';
import '../models/actions.dart';

class ActionsProvider extends ChangeNotifier {
  List<ActionModel> actions = [];
  bool isThereIsNextPage = true;
  void addItemsToTheList(List<ActionModel> list) {
    list.forEach((element) {
      actions.add(element);
    });
    notifyListeners();
  }
}
