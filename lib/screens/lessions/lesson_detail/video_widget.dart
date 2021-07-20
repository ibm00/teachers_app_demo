import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VideoCardWidget extends StatelessWidget {
  const VideoCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * 0.06),
        margin: EdgeInsets.all(10),
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
              'مذكرة شابتر ٦',
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
    );
  }
}
