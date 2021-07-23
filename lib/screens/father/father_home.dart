import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants.dart';
import '../auth/login_screen.dart';

class FatherHomeScreen extends StatelessWidget {
  const FatherHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
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
                'عبعال السيد عبعال',
                style: TextStyle(fontSize: w * 0.055, color: Colors.black),
              ),
              Text(
                ' sdaw123',
                style: TextStyle(
                  fontSize: w * 0.05,
                  color: Colors.black.withAlpha(180),
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
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                      child: Divider(
                        color: Colors.black12,
                        height: 3,
                      ),
                    ),
                    itemCount: 300,
                    itemBuilder: (context, index) {
                      bool isAttend = index.isEven;
                      return index == 0
                          ? Text(
                              'سجل الغياب والحضور',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: w * 0.055, color: kPrimaryColor),
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
                                  'السبت',
                                  style: TextStyle(fontSize: w * 0.05),
                                ),
                                subtitle: Text(
                                  'ايي9 مايو , 2021 الساعه 9:30 مساءا',
                                  style: TextStyle(fontSize: w * 0.03),
                                ),
                              ),
                            );
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
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                      child: Divider(
                        color: Colors.black12,
                        height: 3,
                      ),
                    ),
                    itemCount: 300,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Text(
                              'الامتحانات',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: w * 0.06, color: kPrimaryColor),
                            )
                          : Directionality(
                              textDirection: TextDirection.rtl,
                              child: ListTile(
                                trailing: Text(
                                  "15/${20}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: w * 0.04),
                                ),
                                title: Text(
                                  'اسم الامتحان',
                                  style: TextStyle(fontSize: w * 0.05),
                                ),
                                subtitle: Text(
                                  'ايي9 مايو , 2021 الساعه 9:30 مساءا',
                                  style: TextStyle(fontSize: w * 0.03),
                                ),
                              ),
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
