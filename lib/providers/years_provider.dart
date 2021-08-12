import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/year_model.dart';

final yearsProvider = ChangeNotifierProvider((ref) => YearsProvider());

class YearsProvider extends ChangeNotifier {
  List<YearModel> years = [];

  void fromListToObject(List list) {
    years = list.map((e) {
      return YearModel(
        id: e['id'] as int,
        term: e['term'] as String,
        year: e['name'] as String,
      );
    }).toList();
    print("السنييييييييييييييين");
    print(years[0].year);
  }
}
