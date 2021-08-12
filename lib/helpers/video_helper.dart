import 'package:direct_link/direct_link.dart';
import '../models/video_model.dart';
import '../widgets/dialogs/flutter_toast.dart';

import '../constants.dart';

class VideoHelper {
  static Future<List<VideoModel>?> getValidUrlForVideo(String url) async {
    List<String> list = url.split('/').toList();
    List<VideoModel> links = [];
    if (url.contains('https://drive.google.com')) {
      links.add(
        VideoModel(
            quality: 'there is one quality', url: getGoolgeDriveVideoUrl(list)),
      );
      return links;
    }
    try {
      var check = await DirectLink.check(url);

      check!.forEach((e) {
        links.add(VideoModel(quality: e.quality, url: e.link));
      });

      return links;
    } catch (e) {
      if (url.substring(url.length - 4, url.length) == '.mp4') {
        links.add(
          VideoModel(quality: 'there is one quality', url: url),
        );
        return links;
      }

      showCustomToast('تعذر فتح الفيديو');
      return null;
    }
  }

  static String getGoolgeDriveVideoUrl(List splitedUrl) {
    int index = splitedUrl.indexWhere((e) => e == 'd');
    return 'https://www.googleapis.com/drive/v3/files/${splitedUrl[index + 1]}?alt=media&key=$DRIVEAPIKEY&v=.mp4';
  }
}
