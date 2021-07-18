import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teachers_app/services/device_info.dart';
import '../constants.dart';

class AuthAPI {
  static Future<String?> loginMe({
    String? userName,
    String? password,
    String? mobileId = "123",
  }) async {
    final String mobileInfo = await DeviceInfoService.getMobileId();
    final Uri url = Uri.parse("$APP_API/rest-auth/login/");
    final res = await http.post(
      url,
      body: json.encode(
        {
          "username": userName,
          "password": password,
          "mobile_id": "$mobileInfo/$userName",
        },
      ),
    );
    if (res.statusCode == 200) {
      final token = json.decode(res.body) as Map<String?, String?>;
      print(token);
      return token["key"];
    } else {
      throw Exception();
    }
  }

  static Future<Map<String, Object>> registerMe({
    String? userName,
    String? name,
    String? password1,
    String? password2,
    String? year,
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
    );
    if (res.statusCode == 200) {
      final Map<String, String> dataMap =
          json.decode(res.body) as Map<String, String>;
      print(json.decode(res.body));
      return dataMap;
    } else {
      throw Exception();
    }
  }
}
