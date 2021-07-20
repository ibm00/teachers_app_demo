import '../constants.dart';

class PdfHelper {
  static String getValidPdfUrl(String url) {
    List list = url.split('/').toList();
    int index = list.indexWhere((e) => e == 'd');
    String newUrl =
        'https://www.googleapis.com/drive/v3/files/${list[index + 1]}?alt=media&key=$DRIVEAPIKEY&v=.pdf';
    return newUrl;
  }
}
