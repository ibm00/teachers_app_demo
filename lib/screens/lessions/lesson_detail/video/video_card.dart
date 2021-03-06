import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../helpers/video_helper.dart';
import '../../../../models/video_model.dart';
import 'video_preview.dart';

class VideoCardWidget extends StatelessWidget {
  final String title;
  final String videoUrl;
  const VideoCardWidget({
    required this.title,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: () async {
        print(videoUrl);
        List<VideoModel>? list =
            await VideoHelper.getValidUrlForVideo(videoUrl);
        if (list != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => VideoPreviewScreen(
                        videos: list,
                      )));
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          margin: const EdgeInsets.all(10),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
            child: ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: w * 0.05,
              ),
              leading: SvgPicture.asset(
                'assets/images/video_icon.svg',
                width: w * 0.15,
                height: or == Orientation.portrait ? h * 0.07 : h * 0.2,
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontSize: w * 0.04,
                ),
              ),
              subtitle: Text(
                'فيديو',
                style: TextStyle(
                  fontSize: w * 0.04,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
