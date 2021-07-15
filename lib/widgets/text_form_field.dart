import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    required this.mediaQuery,
    required this.onSaveData,
    required this.validatorFun,
    required this.phoneH,
  });

  final Size mediaQuery;
  final double phoneH;
  final Function(String?)? onSaveData;
  final String? Function(String?)? validatorFun;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: .08 * phoneH,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          onSaved: onSaveData,
          validator: validatorFun,
          style: TextStyle(
            fontSize: .0444 * mediaQuery.width,
            height: 1 + (mediaQuery.height * .0001),
          ),
          decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Theme.of(context).errorColor,
              ),
            ),
            filled: true,
            fillColor: const Color(0xFFF4F4F4),
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
