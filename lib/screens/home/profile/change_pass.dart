import 'package:flutter/material.dart';
import 'package:teachers_app/api/auth_api.dart';
import 'package:teachers_app/helpers/validators.dart';
import 'package:teachers_app/providers/user_data_provider.dart';
import 'package:teachers_app/widgets/dialogs/flutter_toast.dart';
import 'package:teachers_app/widgets/text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  String oldPass = '';
  String newPass = '';
  String reNewPass = '';
  final TextEditingController _passController = TextEditingController();

  bool _oldPassVisiblity = false;
  bool _passVisiblity = false;
  bool _rePassVisiblity = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final orn = MediaQuery.of(context).orientation;
    final _phoneHeight =
        orn == Orientation.portrait ? mediaQuery.height : mediaQuery.width;
    final TextStyle _resTextStyle14 =
        TextStyle(fontSize: 0.0388 * mediaQuery.width, color: Colors.white);
    return Padding(
      padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 5,
          bottom: MediaQuery.of(context).viewInsets.bottom + 5),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "أدخل كلمة المرور القديمة",
                        style: _resTextStyle14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: MyTextFormField(
                        textColor: Colors.white,
                        col: const Color(0xFF373737),
                        mySuffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _oldPassVisiblity = !_oldPassVisiblity;
                            });
                          },
                          icon: _oldPassVisiblity
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        textFieldIcon: const Icon(
                          Icons.lock,
                          color: Color(0xFFFEC105),
                        ),
                        passField: !_oldPassVisiblity,
                        phoneH: _phoneHeight,
                        mediaQuery: mediaQuery,
                        onSaveData: (v) {
                          oldPass = v!;
                        },
                        validatorFun: (v) => ValidatorHelper.passValidator(v!),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "أدخل كلمة المرور الجديدة",
                        style: _resTextStyle14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: MyTextFormField(
                        textColor: Colors.white,
                        col: const Color(0xFF373737),
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
                        textFieldIcon: const Icon(
                          Icons.lock,
                          color: Color(0xFFFEC105),
                        ),
                        passField: !_passVisiblity,
                        myController: _passController,
                        phoneH: _phoneHeight,
                        mediaQuery: mediaQuery,
                        onSaveData: (v) {
                          newPass = v!;
                        },
                        validatorFun: (v) => ValidatorHelper.passValidator(v!),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "أعد كتابة كلمة المرور الجديدة",
                        style: _resTextStyle14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: MyTextFormField(
                        textColor: Colors.white,
                        col: const Color(0xFF373737),
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
                        textFieldIcon: const Icon(
                          Icons.lock,
                          color: Color(0xFFFEC105),
                        ),
                        passField: !_rePassVisiblity,
                        phoneH: _phoneHeight,
                        mediaQuery: mediaQuery,
                        onSaveData: (v) {
                          reNewPass = v!;
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
              TextButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  _formKey.currentState!.save();
                  final String message = await AuthAPI.changePass(
                    oldPass,
                    newPass,
                    reNewPass,
                    context.read(userDataProvider).token,
                  );
                  if (message == "تم تغيير كلمة المرور بنجاح") {
                    Navigator.of(context).pop();
                  }
                  showCustomToast(message);
                },
                child: Text(
                  "حفظ",
                  style: TextStyle(
                    fontSize: mediaQuery.width * .045,
                    color: const Color(0xFFFEC105),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
