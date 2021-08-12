import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/widgets/dialogs/flutter_toast.dart';
import '../../../providers/years_provider.dart';
import '../../../api/auth_api.dart';

import '../../../helpers/validators.dart';
import '../../../widgets/text_form_field.dart';

enum Years {
  one,
  two,
  three,
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String userName = "";
  String name = "";
  String phone = "";
  String dadPhone = "";
  String pass = "";
  String rePass = "";
  int? studentYear;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  bool _passVisiblity = false;
  bool _rePassVisiblity = false;

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
                        "اسم المستخدم",
                        style: _resTextStyle14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: MyTextFormField(
                          textFieldIcon: const Icon(Icons.account_circle),
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
                        "الاسم بالكامل",
                        style: _resTextStyle14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: MyTextFormField(
                          textFieldIcon: const Icon(Icons.person),
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
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Consumer(
                            builder: (context, watch, child) {
                              final yearProv = watch(yearsProvider);
                              return DropdownButton(
                                hint: const Text("اختار السنة"),
                                isExpanded: true,
                                value: studentYear,
                                items: yearProv.years
                                    .map((e) => DropdownMenuItem(
                                          value: e.id,
                                          child: Text(e.year),
                                        ))
                                    .toList(),
                                onChanged: (int? v) {
                                  setState(() {
                                    studentYear = v;
                                  });
                                },
                              );
                            },
                          ),
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
                          textFieldIcon: const Icon(Icons.phone_enabled),
                          myKeyboardType: TextInputType.phone,
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
                          textFieldIcon: const Icon(Icons.phone_enabled),
                          myKeyboardType: TextInputType.phone,
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
                          myController: _passController,
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
                          mySuffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _rePassVisiblity = !_rePassVisiblity;
                              });
                            },
                            icon: _rePassVisiblity
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                          textFieldIcon: const Icon(Icons.lock),
                          passField: !_rePassVisiblity,
                          phoneH: _phoneHeight,
                          mediaQuery: mediaQuery,
                          onSaveData: (v) {
                            rePass = v!;
                          },
                          validatorFun: (v) => ValidatorHelper.rePassValidator(
                            v!,
                            _passController.text,
                          ),
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
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                if (studentYear == null) {
                  showCustomToast("من فضلك أختار السنة الدراسية");
                  return;
                }
                _formKey.currentState!.save();
                await AuthAPI.registerMe(
                  context: context,
                  userName: userName,
                  name: name,
                  fatherPhone: dadPhone,
                  password1: pass,
                  password2: rePass,
                  phoneNumber: phone,
                  year: studentYear,
                );
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
