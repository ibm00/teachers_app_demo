import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teachers_app/api/auth_api.dart';
import 'package:teachers_app/providers/user_data_provider.dart';
import '../constants.dart';

final startAppLogicProvider = FutureProvider<UserStatus>((ref) async {
  String? token = GetStorage().read('token');
  bool? isStudent = GetStorage().read('isStudent');
  print('*****');
  print(token);
  print(isStudent);
  if (token == null) {
    return UserStatus.notLogged;
  }
  if (isStudent == false) {
    return UserStatus.loggedFather;
  }
  Map? userData = await AuthAPI.getStudentDetails(token);
  if (userData == null) {
    // that mean error occuerd or no internet connection
    return UserStatus.loggedFather;
  } else {
    bool isActive = userData['active'] as bool;
    if (isActive) {
      ref.read(userDataProvider).token = token;
      ref.read(userDataProvider).fromMap(userData);
      return UserStatus.loggedStudent;
    } else {
      return UserStatus.disActive;
    }
  }
});
