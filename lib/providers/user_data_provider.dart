
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider =
    ChangeNotifierProvider<_UserDataProvider>((ref) => _UserDataProvider());

class _UserDataProvider extends ChangeNotifier {
  String token = '7ba1a288998a4ac5b339d493ff121a8856d6811b';
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
    // fullName = map['fullName'];
    //groupName = map['groupName'];
    yearName = map['year'] as String;
    fatherCode = (map['father_code'] as int).toString();
  }
}
