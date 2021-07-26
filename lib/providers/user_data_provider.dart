import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/models/attendance_model.dart';
import 'package:translator/translator.dart';

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
  List<Attendance> attendance = [];

  void fromMap(Map map) async {
    userName = map['username'] as String;
    fullName = map['full_name'] as String;
    yearName = map['year'] as String;
    fatherCode = (map['father_code'] as int).toString();
    attendance = _findAttendanceRecord(map["attendees"] as String);
    // print("استخدمت ال فورماااااااااات");
    // final enDate = DateFormat.MMMMEEEEd().format(
    //   DateTime.parse(attendance[0].date),
    // );

    // print(enDate);
    // GoogleTranslator().translate(enDate, from: 'en', to: 'ar').then((s) {
    //   print(s);
    // });
  }

  List<Attendance> _findAttendanceRecord(String attendanceString) {
    final List<String> attendaceList = attendanceString.split(",");
    return attendaceList
        .map(
          (e) => Attendance(
            attendance: e.substring(15, 19).toLowerCase() == 'true',
            date: e.substring(2, 12),
          ),
        )
        .toList();
  }
}
