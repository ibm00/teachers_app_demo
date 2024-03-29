import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teachers_app/screens/home/profile/change_pass.dart';
import '../../auth/login_screen.dart';
import 'obout_screen.dart';

import '../../../providers/user_data_provider.dart';
import 'attendence.dart';

class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final userData = watch(userDataProvider);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: w > 600
                  ? const EdgeInsets.only(right: 30)
                  : const EdgeInsets.only(right: 0.1),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: w * 0.07,
                      color: Colors.white,
                    )),
              ),
            ),
            SvgPicture.asset(
              'assets/images/user_image.svg',
              width: w * 0.33,
            ),
            Text(
              userData.fullName,
              style: TextStyle(fontSize: w * 0.055, color: Colors.white),
            ),
            Text(
              userData.userName,
              style: TextStyle(
                fontSize: w * 0.05,
                color: Colors.white.withAlpha(180),
              ),
            ),
            Text(
              'المجموعة: ${userData.groupName}',
              style: TextStyle(
                fontSize: w * 0.05,
                color: Colors.white.withAlpha(180),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userData.fatherCode,
                  style: TextStyle(
                    fontSize: w * 0.04,
                    color: Colors.white.withAlpha(180),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  backgroundColor: const Color(0xFFFEC105),
                  radius: w * 0.05,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: userData.fatherCode));
                          Fluttertoast.showToast(
                              msg: "تم النسخ",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 20);
                        },
                        icon: Icon(
                          Icons.copy,
                          color: Colors.black,
                          size: w * 0.04,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: const Color(0xFFFEC105),
                  radius: w * 0.05,
                  child: IconButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "كود ولي الأمر",
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 20);
                      },
                      icon: Icon(
                        CupertinoIcons.question,
                        color: Colors.black,
                        size: w * 0.04,
                      )),
                ),
              ],
            ),
            // _buildOptionsItem(
            //     context: context,
            //     text: 'الخصوصية',
            //     callback: () {
            //       context.read(loadingProvider).state = true;
            //     },
            //     iconData: Icons.privacy_tip),
            _buildOptionsItem(
                context: context,
                text: 'سجل الغياب',
                callback: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AttendanceScreen(),
                    ),
                  );
                },
                iconData: Icons.menu_book),
            _buildOptionsItem(
                context: context,
                text: 'تغيير كلمة المرور',
                callback: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (_) {
                        return ChangePass();
                      },
                      backgroundColor: const Color(0xFF212121));
                },
                iconData: Icons.lock),
            _buildOptionsItem(
                context: context,
                text: 'حول التطبيق',
                callback: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AboutScreen(),
                    ),
                  );
                },
                iconData: Icons.info),
            _buildOptionsItem(
              context: context,
              text: 'تسجيل الخروج',
              callback: () {
                GetStorage().erase();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              iconData: Icons.exit_to_app,
            )
          ],
        ),
      )),
    );
  }

  Widget _buildOptionsItem(
      {required BuildContext context,
      required String text,
      required VoidCallback callback,
      required IconData iconData}) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: or == Orientation.portrait ? h * 0.066 : h * 0.3,
        width: w * 0.85,
        margin: const EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: w * 0.07),
        decoration: BoxDecoration(
          color: const Color(0xFF373737),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              size: w * 0.06,
              color: Colors.white,
            ),
            const Spacer(
              flex: 8,
            ),
            Text(
              text,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: w * 0.05, color: Colors.white),
            ),
            const Spacer(
              flex: 1,
            ),
            Icon(
              iconData,
              size: w * 0.06,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
