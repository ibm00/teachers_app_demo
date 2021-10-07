// ignore_for_file: avoid_classes_with_only_static_members

class ValidatorHelper {
  static String? nameValidator(String data) {
    final List names = data.split(" ");
    names.removeWhere((element) => element == "");
    if (data.trim().isEmpty) return "أدخل أسمك بالكامل";
    if (names.length < 3) return "يجب أن يكون الاسم ثلاثي على الأقل";
  }

  static String? emailValidator(String data) {
    if (!data.contains(".com") || !data.contains("@")) {
      return "أدخل بريد إلكتروني صحيح";
    }
    return null;
  }

  static String? userNameValidator(String data) {
    if (data.length < 4) return "يجب ألا ييقل رقم الهاتف عن 4 أرقام";
  }

  static String? phoneNumValidator(String data) {
    if (int.tryParse(data) == null) return "أدخل رقم هاتف صالح";
    if (data.length < 11) return "يجب ألا ييقل رقم الهاتف عن 11 رقم";
  }

  static String? passValidator(String data) {
    if (data.length < 8) return "يجب ألا تقل كلمة المرور عن 8 خانات";
  }

  static String? rePassValidator(String data, String data2) {
    if (data != data2) return "يجب أن تكون كلمتي المرور متشابهتين";
  }
}
