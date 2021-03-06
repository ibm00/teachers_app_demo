import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intil;
import 'package:teachers_app/providers/attendance_provider.dart';
import '../../../constants.dart';
import '../../../models/attendance_model.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final  double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    final Orientation or = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: w * 0.06,
            )),
        centerTitle: true,
        title: Text(
          'سجل الحضور والغياب',
          style: TextStyle(color: Colors.black, fontSize: w * 0.05),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(top: 20, left: w * 0.06, right: w * 0.06),
        child: Card(
          color: Colors.white,
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Consumer(
            builder: (context, watch, child) {
              final attendanceRecord = watch(attendanceProvider);
              return attendanceRecord.when(
                data: (attendancList) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                      child: Divider(
                        color: Colors.black12,
                        height: 3,
                      ),
                    ),
                    itemCount:
                        attendancList.length + (attendancList.isEmpty ? 0 : 1),
                    itemBuilder: (context, index) {
                      final Attendance currentDayAtt =
                          attendancList[(index == 0) ? 0 : index - 1];
                      final bool isAttend = currentDayAtt.attendance;
                      return index == 0
                          ? Text(
                              'الحصص',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: w * 0.06, color: kPrimaryColor),
                            )
                          : Directionality(
                              textDirection: TextDirection.rtl,
                              child: ListTile(
                                trailing: isAttend
                                    ? Icon(
                                        Icons.check,
                                        color: kPrimaryColor,
                                        size: w * 0.06,
                                      )
                                    : Icon(
                                        Icons.close,
                                        size: w * 0.06,
                                        color: Colors.black,
                                      ),
                                title: Text(
                                  intil.DateFormat.EEEE()
                                      .format(currentDayAtt.date),
                                  style: TextStyle(fontSize: w * 0.05),
                                ),
                                subtitle: Text(
                                  intil.DateFormat.MMMMd()
                                      .format(currentDayAtt.date),
                                  style: TextStyle(fontSize: w * 0.03),
                                ),
                              ),
                            );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) =>
                    const Center(child: Text("Some thing went wrong.")),
              );
              // final List<Attendance> attendancList =
              //     attendanceRecord.attendance;
            },
          ),
        ),
      ),
    );
  }
}
