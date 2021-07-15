class ValidatorHelper {
  static String? nameValidator(String data) {
    final List names = data.split(" ");
    names.removeWhere((element) => element == "");
    if (data.trim().isEmpty) return "أدخل أسمك بالكامل";
    if (names.length < 3) return "يجب أن يكون الاسم ثلاثي على الأقل";
  }

  static String? phoneNumValidator(String data) {
    if (int.tryParse(data) == null) return "أدخل رقم هاتف صالح";
    if (data.length < 11) return "يجب ألا ييقل رقم الهاتف عن 11 رقم";
  }

  static String? passValidator(String data) {
    if (data.length < 8) return "يجب ألا تقل كلمة المرور عن 8 خانات";
  }
}
