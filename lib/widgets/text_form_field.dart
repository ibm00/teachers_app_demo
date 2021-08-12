import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {required this.mediaQuery,
      required this.onSaveData,
      required this.validatorFun,
      required this.phoneH,
      this.myController,
      this.myKeyboardType,
      this.passField = false,
      this.textFieldIcon,
      this.mySuffixIcon,
      this.col = const Color(0xFFF4F4F4),
      this.textColor = Colors.black});

  final Size mediaQuery;
  final double phoneH;
  final Function(String?)? onSaveData;
  final String? Function(String?)? validatorFun;
  final TextEditingController? myController;
  final TextInputType? myKeyboardType;
  final bool passField;
  final Icon? textFieldIcon;
  final Widget? mySuffixIcon;
  final Color col;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          obscureText: passField,
          keyboardType: myKeyboardType,
          controller: myController,
          onSaved: onSaveData,
          validator: validatorFun,
          style: TextStyle(
              fontSize: .0444 * mediaQuery.width,
              height: 1 + (mediaQuery.height * .0001),
              color: textColor),
          decoration: InputDecoration(
            suffixIcon: mySuffixIcon,
            prefixIcon: textFieldIcon,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Theme.of(context).errorColor,
              ),
            ),
            filled: true,
            fillColor: col,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color(0xFF398CE0))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color(0xFFF4F4F4))),
          ),
        ),
      ),
    );
  }
}
