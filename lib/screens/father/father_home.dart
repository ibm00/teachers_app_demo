import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart' as intil;
import 'package:teachers_app/providers/attendance_provider.dart';
import '../../models/attendance_model.dart';
import '../../models/quiz_models.dart';
import '../../providers/quiz_provider.dart';
import '../../providers/user_data_provider.dart';

import '../../constants.dart';
import '../auth/login_screen.dart';

class FatherHomeScreen extends StatelessWidget {
  const FatherHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    final userData = context.read(userDataProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  GetStorage().erase();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      ' تسجيل الخروج',
                      style: TextStyle(fontSize: w * 0.04),
                    ),
                    Icon(
                      Icons.exit_to_app_sharp,
                      size: w * 0.07,
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/images/user_image.svg',
                width: w * 0.33,
              ),
              Text(
                'حساب ولي أمر الطالب \n${userData.fullName}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: w * 0.055, color: Colors.black),
              ),
              // Text(
              //   ' sdaw123',
              //   style: TextStyle(
              //     fontSize: w * 0.05,
              //     color: Colors.black.withAlpha(180),
              //   ),
              // ),
              Container(
                width: double.infinity,
                height: or == Orientation.portrait ? h * 0.5 : h * 2,
                margin:
                    EdgeInsets.only(top: 20, left: w * 0.06, right: w * 0.06),
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Consumer(
                    builder: (context, watch, child) {
                      final attendanceRecord = watch(attendanceProvider);
                      return attendanceRecord.when(
                        data: (attendancList) {
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                              child: Divider(
                                color: Colors.black12,
                                height: 3,
                              ),
                            ),
                            itemCount: attendancList.length +
                                (attendancList.isEmpty ? 0 : 1),
                            itemBuilder: (context, index) {
                              final Attendance currentDayAtt =
                                  attendancList[(index == 0) ? 0 : index - 1];
                              final bool isAttend = currentDayAtt.attendance;
                              return index == 0
                                  ? Text(
                                      'الحصص',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: w * 0.06,
                                          color: kPrimaryColor),
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
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, s) =>
                            const Center(child: Text("Some thing went wrong.")),
                      );
                      // final List<Attendance> attendancList =
                      //     attendanceRecord.attendance;
                    },
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: or == Orientation.portrait ? h * 0.5 : h * 2,
                margin:
                    EdgeInsets.only(top: 20, left: w * 0.06, right: w * 0.06),
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Consumer(
                    builder: (context, watch, child) {
                      final oldQuzProvider = watch(oldQuizProvider);
                      return oldQuzProvider.when(
                        data: (qezList) {
                          //qezList.insert(0, qezList[0]);
                          print("lenth of quz list: ${qezList.length}");
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                              child: Divider(
                                color: Colors.black12,
                                height: 3,
                              ),
                            ),
                            itemCount:
                                qezList.length + (qezList.isEmpty ? 0 : 1),
                            itemBuilder: (context, index) {
                              final OldQuizModel currentQuz =
                                  qezList[(index == 0) ? 0 : index - 1];
                              return index == 0
                                  ? Text(
                                      'الامتحانات',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: w * 0.06,
                                          color: kPrimaryColor),
                                    )
                                  : Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: ListTile(
                                        trailing: Text(
                                          "${currentQuz.studentMark}/${currentQuz.fullMark}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: w * 0.04),
                                        ),
                                        title: Text(
                                          currentQuz.title,
                                          style: TextStyle(fontSize: w * 0.05),
                                        ),
                                        subtitle: Text(
                                          currentQuz.time,
                                          style: TextStyle(fontSize: w * 0.03),
                                        ),
                                      ),
                                    );
                            },
                          );
                        },
                        loading: () {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        error: (error, stack) {
                          //TO-DO....................
                          return const Center(
                            child: Text("حدث مشكلة حاول مرة أخرى لاحقا"),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
