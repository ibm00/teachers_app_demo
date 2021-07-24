import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider =
    ChangeNotifierProvider<_UserDataProvider>((ref) => _UserDataProvider());

class _UserDataProvider extends ChangeNotifier {
  String token = 'b9046ebe4138b3eb564554d68f9ec19d546fa7ea';
  bool isStudent = true;
  String userName = 'ahmed123';
  String fullName = 'احمد فرج السكري';
  String password1 = '';
  String password2 = '';
  String groupName = 'مجموعة ٢ السبت';
  String yearName = 'الصف الثالت الثانوي';
  String fatherCode = '54g658e7rt86e7rt86';

  void fromMap(Map map) {
    userName = map['username'] as String;
    fullName = map['full_name'] as String;
    //groupName = map['groupName'];
    yearName = map['year'] as String;
    fatherCode = (map['father_code'] as int).toString();
  }
}
