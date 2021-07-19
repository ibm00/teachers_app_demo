import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teachers_app/screens/auth/login_screen.dart';
import 'register_form.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final orn = MediaQuery.of(context).orientation;
    final _phoneHeight =
        orn == Orientation.portrait ? mediaQuery.height : mediaQuery.width;
    final _phoneWidth =
        orn == Orientation.portrait ? mediaQuery.width : mediaQuery.height;
    // final TextStyle _myTextStyle =
    //     TextStyle(fontSize: .0388 * mediaQuery.width);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: _phoneHeight * .01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: SvgPicture.asset(
                          "assets/images/need_helpe.svg",
                          width: .1 * mediaQuery.width,
                          height: mediaQuery.width * .06,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          exit(0);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 0.05 * _phoneWidth,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: .01 * _phoneHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset("assets/images/lets_start.svg",
                          width: .3 * mediaQuery.width,
                          height: .12 * mediaQuery.width),
                      const SizedBox(height: 6),
                      const Text("قم بتسجيل حساب جديد للإستمرار")
                    ],
                  ),
                ),
                RegisterForm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                      child: Text(
                        "قم بتسجيل الدخول",
                        style: TextStyle(
                          color: const Color(0xFF121213),
                          fontSize: .0222 * mediaQuery.width,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                      child: Text(
                        "لديك حساب بالفعل؟",
                        style: TextStyle(
                          color: const Color(0xFFC0C0C0),
                          fontSize: .0222 * mediaQuery.width,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
