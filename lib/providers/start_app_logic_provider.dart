import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/constants.dart';

final startAppLogicProvider = FutureProvider<UserStatus>((ref) async {
  await Future.delayed(Duration(seconds: 2));
  // add the logic of starting here y broooo
  return UserStatus.notLogged;
});
