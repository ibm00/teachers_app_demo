import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/api/auth_api.dart';
import 'package:teachers_app/models/attendance_model.dart';
import 'package:teachers_app/providers/user_data_provider.dart';

final attendanceProvider =
    FutureProvider.autoDispose<List<Attendance>>((ref) async {
  final studentDetails =
      await AuthAPI.getStudentDetails(ref.read(userDataProvider).token);
  final studentAttendanceString = studentDetails!['attendees'] as String;
  final List<Attendance> studentAttendaceList =
      _findAttendanceRecord(studentAttendanceString);
  return studentAttendaceList;
});

List<Attendance> _findAttendanceRecord(String attendanceString) {
  final List<String> attendaceList = attendanceString.split(",");
  return attendaceList
      .map(
        (e) => Attendance(
          attendance: e.substring(15, 19).toLowerCase() == 'true',
          date: DateTime.parse(
            e.substring(2, 12),
          ),
        ),
      )
      .toList()
      .reversed
      .toList()
        ..removeWhere((element) => element.date.isAfter(DateTime.now()));
}
