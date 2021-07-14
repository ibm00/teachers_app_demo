import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'register_form.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final orn = MediaQuery.of(context).orientation;
    final _phoneHeight =
        orn == Orientation.portrait ? mediaQuery.height : mediaQuery.width;
    final _phoneWidth =
        orn == Orientation.portrait ? mediaQuery.width : mediaQuery.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .03),
            height: (_phoneHeight - MediaQuery.of(context).padding.top) * 1.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 140,
                        child: Column(
                          children: const [
                            Text("هل تحتاج إلى مساعدة؟"),
                            Divider(
                              height: 0.1,
                              indent: 11,
                              thickness: 1,
                              color: Color(0x99707070),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset("assets/images/lets_start.svg"),
                        const Text("قم بتسجيل حساب جديد للإستمرار")
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: RegisterForm(),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Switch(
                          activeColor: const Color(0xFF55DFA2),
                          value: _rememberMe,
                          onChanged: (v) {
                            setState(() {
                              _rememberMe = v;
                            });
                          },
                        ),
                        const Text("تذكرني"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: mediaQuery.width * .8,
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder?>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(10),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF4D68D4),
                        ),
                      ),
                      child: const Text("تسجيل"),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "قم بتسجيل الدخول",
                          style: TextStyle(
                            color: Color(0xFF121213),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "لديك حساب بالفعل؟",
                          style: TextStyle(
                            color: Color(0xFFC0C0C0),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
