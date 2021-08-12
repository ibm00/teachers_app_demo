import 'package:translator/translator.dart';

class TranslateHelper {
  static Future<String> pleaseTranslateThis(String source) async {
    final translator = GoogleTranslator();
    final translatedObject =
        await translator.translate(source, from: 'en', to: 'ar');
    return translatedObject.text;
  }
}
