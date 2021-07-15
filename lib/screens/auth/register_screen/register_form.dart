import 'package:flutter/material.dart';

import '../../../helpers/validators.dart';
import '../../../widgets/text_form_field.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  //void _saveData
  String name = "";
  String year = "";
  String phone = "";
  String dadPhone = "";
  String pass = "";
  String rePass = "";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final orn = MediaQuery.of(context).orientation;
    final _phoneHeight =
        orn == Orientation.portrait ? mediaQuery.height : mediaQuery.width;
    final TextStyle _resTextStyle14 =
        TextStyle(fontSize: 0.0388 * mediaQuery.width);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "الاسم بالكامل",
                        style: _resTextStyle14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: MyTextFormField(
                          phoneH: _phoneHeight,
                          mediaQuery: mediaQuery,
                          onSaveData: (v) {
                            name = v!;
                          },
                          validatorFun: (v) =>
                              ValidatorHelper.nameValidator(v!),
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
                        "السنة الدراسية",
                        style: _resTextStyle14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: MyTextFormField(
                          phoneH: _phoneHeight,
                          mediaQuery: mediaQuery,
                          onSaveData: (v) {
                            year = v!;
                          },
                          validatorFun: (v) =>
                              ValidatorHelper.nameValidator(v!),
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
                        "رقم الهاتف",
                        style: _resTextStyle14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: MyTextFormField(
                          phoneH: _phoneHeight,
                          mediaQuery: mediaQuery,
                          onSaveData: (v) {
                            phone = v!;
                          },
                          validatorFun: (v) =>
                              ValidatorHelper.phoneNumValidator(v!),
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
                        "رقم هاتف ولي الأمر",
                        style: _resTextStyle14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: MyTextFormField(
                          phoneH: _phoneHeight,
                          mediaQuery: mediaQuery,
                          onSaveData: (v) {
                            dadPhone = v!;
                          },
                          validatorFun: (v) =>
                              ValidatorHelper.phoneNumValidator(v!),
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
                        "كلمة المرور",
                        style: _resTextStyle14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: MyTextFormField(
                          phoneH: _phoneHeight,
                          mediaQuery: mediaQuery,
                          onSaveData: (v) {
                            pass = v!;
                          },
                          validatorFun: (v) =>
                              ValidatorHelper.passValidator(v!),
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
                        "أعد كتابة كلمة المرور",
                        style: _resTextStyle14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: MyTextFormField(
                          phoneH: _phoneHeight,
                          mediaQuery: mediaQuery,
                          onSaveData: (v) {
                            rePass = v!;
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
          margin: EdgeInsets.symmetric(vertical: .015 * _phoneHeight),
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              width: mediaQuery.width * .8,
              height: .1 * mediaQuery.width,
            ),
            child: ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                _formKey.currentState!.save();
                print(name);
                print(year);
                print(phone);
                print(dadPhone);
                print(pass);
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
                "تسجيل",
                style: TextStyle(fontSize: .0388 * mediaQuery.width),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
