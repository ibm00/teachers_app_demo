import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider =
    ChangeNotifierProvider<_UserDataProvider>((ref) => _UserDataProvider());

class _UserDataProvider extends ChangeNotifier {
  String token = '4282975c1edfe8c51d44dbc3db1bd95c17fe4b02';
  String userName = 'ahmed123';
  String fullName = 'احمد فرج السكري';
  String password1 = '';
  String password2 = '';
  String groupName = 'مجموعة ٢ السبت';
  String yearName = 'الصف الثالت الثانوي';
  String fatherCode = '54g658e7rt86e7rt86';
}
