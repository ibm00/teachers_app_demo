import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../screens/auth/after_registeration_page.dart';
import '../services/device_info.dart';
import '../widgets/dialogs/flutter_toast.dart';

class AuthAPI {
  static Future<String> confirmAttendance(String token, String day) async {
    try {
      http.Response res = await http.post(Uri.parse('$APP_API/api/me/att/'),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Token $token',
          },
          body: json.encode({'day': day}));
      final Map data = json.decode(utf8.decode(res.bodyBytes)) as Map;
      print(data);

      if (res.statusCode != 404) {
        return data['detail'] as String;
      } else {
        return 'لا توجد حصة اليوم';
      }
    } catch (e) {
      print('this is confirm attendance error : $e');
      return 'حدث خطأ الرجاء المحاولة مرة اخري والتأكد من الانترنت';
    }
  }

  static Future<String?>? fatherLogin(String code) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(
            "$APP_API/api/father/login/",
          ),
          headers: <String, String>{
            "Content-Type": "application/json",
          },
          body: json.encode({
            'code': int.parse(code),
          }));
      if (response.statusCode == 200) {
        final Map m = json.decode(response.body) as Map;
        final String token = m['key'] as String;
        GetStorage().write('isStudent', false);
        GetStorage().write('father_code', code);
        return token;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        print(json.decode(response.body));
        showCustomToast('هذا الكود غير مسجل لاي طالب لدينا');
      } else {
        showCustomToast('الرجاء التأكد من الاتصال بالانترنت');
      }
    } catch (e) {
      print(e);
      showCustomToast('حدث خطأ الرجاء المحاولة مرة اخري ');
    }
  }

  static Future<Map?>? getStudentDetails(String token) async {
    try {
      final http.Response response = await http.get(
          Uri.parse("$APP_API/api/me"),
          headers: {"Authorization": "Token $token"});
      if (response.statusCode == 200) {
        List l = json.decode(utf8.decode(response.bodyBytes)) as List;
        final Map userData = l[0] as Map;
        return userData;
      } else {
        print(
            'this is get Student details status code : ${response.statusCode}');
        print(json.decode(response.body));
        showCustomToast('حدث خطأ الرجاء المحاولة مرة اخري لاحقا ');
      }
    } catch (e) {
      print(e);
      showCustomToast('حدث خطأ الرجاء المحاولة مرة اخري لاحقا ');
    }
  }

  static Future<Map> loginMe({
    String? userName,
    String? password,
  }) async {
    final String mobileInfo = await DeviceInfoService.getMobileId();
    final Uri url = Uri.parse("$APP_API/rest-auth/login/");
    final res = await http.post(url,
        body: json.encode(
          {
            "username": userName,
            "password": password,
            "mobile_id": "$mobileInfo/$userName",
            //               "mobile_id": '$mobileInfo/$userName',
          },
        ),
        headers: <String, String>{
          "Content-Type": "application/json",
        });
    final t = json.decode(res.body) as Map;
    print(t);
    if (res.statusCode == 200 || res.statusCode == 201) {
      final token = t["key"] as String;

      return {
        'sucess': true,
        'token': token,
      };
    } else {
      List error1 = (t['detail'] ?? []) as List;
      //   List error2 = t['non_field_errors'] as List;
      return {
        'sucess': false,
        'msg': error1.isEmpty
            ? 'بيانات الطالب غير صحيحة'
            : 'لا يمكن استخدام التطبيق علي اكثر من هاتف',
      };
    }
  }

  static Future? registerMe({
    required BuildContext context,
    String? userName,
    String? name,
    String? password1,
    String? password2,
    int? year,
    String? phoneNumber,
    String? fatherPhone,
  }) async {
    final String mobileInfo = await DeviceInfoService.getMobileId();
    final url = Uri.parse("$APP_API/rest-auth/registration/");
    final res = await http.post(
      url,
      body: json.encode(
        {
          "username": userName,
          "name": name,
          "password1": password1,
          "password2": password2,
          "year": year,
          "phone_number": "+2$phoneNumber",
          "father_phone": "+2$fatherPhone",
          "mobile_id": "$mobileInfo/$userName",
        },
      ),
      headers: <String, String>{
        "Content-Type": "application/json",
      },
    );
    print(res.statusCode);
    final Map data = json.decode(res.body) as Map;
    if (res.statusCode == 200 || res.statusCode == 201) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AfterRegiseterationScreen(),
        ),
      );
    } else if (res.statusCode >= 400 && res.statusCode < 500) {
      if (data['username'] != null) {
        showCustomToast('اسم المستخدم تم استخدامه من قبل');
      } else {
        showCustomToast('تأكد من ادخال رقم هاتف صحيح');
      }
    } else {
      showCustomToast('تأكد من الاتصال بالانترنت');
    }
  }

  static Future<List> getStudyYears() async {
    final url = Uri.parse("$APP_API/api/years/");
    final res = await http.get(url);
    final yearMap = json.decode(utf8.decode(res.bodyBytes)) as List;
    return yearMap;
  }

  static Future<String> changePass(
    String old,
    String newPass,
    String reNewPass,
    String token,
  ) async {
    final url = Uri.parse("$APP_API/rest-auth/password/change/");
    try {
      final res = await http.post(url,
          body: json.encode({
            "old_password": old,
            "new_password1": newPass,
            "new_password2": reNewPass,
          }),
          headers: {
            "Authorization": "Token $token",
            "Content-Type": "application/json",
          });
      final data = json.decode(res.body) as Map;
      print("change pass response : $data");
      if (res.statusCode == 200) {
        return "تم تغيير كلمة المرور بنجاح";
      } else {
        return "كلمة المرور القديمة غير صحيحة";
      }
    } catch (e) {
      print("this is change pass error in catch $e");
      return "هناك مشكلة بالأنترنت حاول لاحقا";
    }
  }
}
