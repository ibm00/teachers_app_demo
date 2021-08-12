import '../constants.dart';

class ImageHelper {
  static String getValidUrl(String url) {
    if (url == '' || url.contains(APP_API)) {
      return url;
    }
    return APP_API + url;
  }
}
