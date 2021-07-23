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
        'url': url,
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
