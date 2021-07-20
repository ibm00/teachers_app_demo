import '../constants.dart';

class VideoHelper {
  static Map<String, dynamic> getValidUrlForVideo(String url) {
    List<String> list = url.split('/').toList();
    bool isYouTubeUrl = false;
    list.forEach((e) {
      if (e.contains("youtube.com")) {
        isYouTubeUrl = true;
      }
    });
    if (isYouTubeUrl) {
      return {
        'isYouTube': isYouTubeUrl,
        'url': convertUrlToId(url),
      };
    } else {
      return url.contains('https://drive.google.com')
          ? getGoolgeDriveVideoUrl(list)
          : {
              'isYouTube': false,
              'url': url,
            };
    }
  }

  static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var regex in [
      r'^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$',
      r'^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$',
      r'^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$',
    ]) {
      Match? match = RegExp(regex).firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  static Map<String, dynamic> getGoolgeDriveVideoUrl(List splitedUrl) {
    int index = splitedUrl.indexWhere((e) => e == 'd');
    String newUrl =
        'https://www.googleapis.com/drive/v3/files/${splitedUrl[index + 1]}?alt=media&key=$DRIVEAPIKEY&v=.mp4';
    return {
      'isYouTube': false,
      'url': newUrl,
    };
  }
}
