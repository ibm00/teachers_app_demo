import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:teachers_app/widgets/dialogs/flutter_toast.dart';
import '../api/auth_api.dart';
import '../constants.dart';
import 'user_data_provider.dart';

final startAppLogicProvider = FutureProvider<UserStatus>((ref) async {
  final String? token = GetStorage().read('token');
  final bool? isStudent = GetStorage().read('isStudent');
  final String? fatherCode = GetStorage().read('father_code');

  print('*****');
  print(token);
  print(isStudent);
  print(fatherCode);
  final bool result = await InternetConnectionChecker().hasConnection;
  if (result) {
    switch (isStudent) {
      case true:
        final Map? userData = await AuthAPI.getStudentDetails(token!);
        if (userData == null) {
          // that mean error occuerd or no internet connection
          return UserStatus.notLogged;
        } else {
          final bool isActive = userData['active'] as bool;
          if (isActive) {
            ref.read(userDataProvider).token = token;
            ref.read(userDataProvider).fromMap(userData);
            return UserStatus.loggedStudent;
          } else {
            return UserStatus.disActive;
          }
        }
      case false:
        String? _token = await AuthAPI.fatherLogin(fatherCode!);
        if (_token == null) {
          return UserStatus.notLogged;
        }
        Map? userData = await AuthAPI.getStudentDetails(_token);
        if (userData == null) {
          return UserStatus.notLogged;
        }

        ref.read(userDataProvider).token = _token;
        ref.read(userDataProvider).fromMap(userData);
        return UserStatus.loggedFather;

      default:
        return UserStatus.notLogged;
    }
  } else {
    showCustomToast('انت غير متصل بالانترنت');
    return UserStatus.noInternet;
  }
});
