import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teachers_app/api/auth_api.dart';
import '../../helpers/validators.dart';
import '../../widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isStudent = true;
  final ButtonStyle _activeButton = ButtonStyle(
    shape: MaterialStateProperty.all<OutlinedBorder?>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
    elevation: MaterialStateProperty.all<double>(12),
    backgroundColor: MaterialStateProperty.all<Color>(
      const Color(0xFF4D68D4),
    ),
  );
  final ButtonStyle _deActiveButton = ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(
      const Color(0x80FFFFFF),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder?>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(
      const Color(0xFFC0C0C0),
    ),
  );
  bool _passVisiblity = false;
  String userName = "";
  String _pass = "";
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final orn = MediaQuery.of(context).orientation;
    final _phoneHeight =
        orn == Orientation.portrait ? mediaQuery.height : mediaQuery.width;
    final _phoneWidth =
        orn == Orientation.portrait ? mediaQuery.width : mediaQuery.height;
    final TextStyle _resTextStyle14 =
        TextStyle(fontSize: 0.0388 * mediaQuery.width);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                          "assets/images/forget_pass.svg",
                          width: .1 * mediaQuery.width,
                          height: mediaQuery.width * .06,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.close,
                          size: 0.05 * _phoneWidth,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: .01 * _phoneHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/images/hello_backP.png",
                        width: 0.4 * mediaQuery.width,
                        height: 0.15 * mediaQuery.width,
                      ),
                      const SizedBox(height: 6),
                      const Text("من فضلك قم بإدخال بياناتك للإستمرار"),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: .035 * _phoneHeight),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                            width: mediaQuery.width * .22,
                            height: .11 * mediaQuery.width,
                          ),
                          child: ElevatedButton(
                            style: _isStudent ? _deActiveButton : _activeButton,
                            onPressed: () {
                              setState(() {
                                _isStudent = false;
                                _formKey.currentState!.reset();
                              });
                            },
                            child: Text(
                              "ولى أمر",
                              style:
                                  TextStyle(fontSize: mediaQuery.width * .035),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                            width: mediaQuery.width * .22,
                            height: .11 * mediaQuery.width,
                          ),
                          child: ElevatedButton(
                            style: _isStudent ? _activeButton : _deActiveButton,
                            onPressed: () {
                              setState(() {
                                _isStudent = true;
                                _formKey.currentState!.reset();
                              });
                            },
                            child: Text(
                              "طالب",
                              style:
                                  TextStyle(fontSize: mediaQuery.width * .035),
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 0.02 * mediaQuery.height,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: .02 * mediaQuery.width),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (_isStudent)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "اسم المستخدم",
                                  style: _resTextStyle14,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: MyTextFormField(
                                    textFieldIcon:
                                        const Icon(Icons.account_circle),
                                    phoneH: _phoneHeight,
                                    mediaQuery: mediaQuery,
                                    onSaveData: (v) {
                                      userName = v!;
                                    },
                                    validatorFun: (v) =>
                                        ValidatorHelper.userNameValidator(v!),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _isStudent ? "كلمة المرور" : "كود الطالب",
                                style: _resTextStyle14,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: MyTextFormField(
                                  mySuffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passVisiblity = !_passVisiblity;
                                      });
                                    },
                                    icon: _passVisiblity
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                  textFieldIcon: const Icon(Icons.lock),
                                  passField: !_passVisiblity,
                                  phoneH: _phoneHeight,
                                  mediaQuery: mediaQuery,
                                  onSaveData: (v) {
                                    _pass = v!;
                                  },
                                  validatorFun: (v) =>
                                      ValidatorHelper.passValidator(v!),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: .04 * _phoneHeight),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: mediaQuery.width * .8,
                      height: .11 * mediaQuery.width,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        _formKey.currentState!.save();
                        AuthAPI.loginMe(password: "1", userName: userName);
                        print(userName);
                        print(_pass);
                      },
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
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(fontSize: .0388 * mediaQuery.width),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: (_isStudent ? 0.01 : 0.08) * _phoneHeight),
                  child: Column(
                    children: [
                      Text(
                        "بأكمال عملية التسجيل فأنت توافق علي",
                        style: TextStyle(
                          fontSize: .03611 * mediaQuery.width,
                          color: const Color(0xFFC0C0C0),
                        ),
                      ),
                      Text(
                        "سياسة وشروط الإستخدام",
                        style: TextStyle(
                          fontSize: .03611 * mediaQuery.width,
                          color: const Color(0xFF121213),
                        ),
                      ),
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
