import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constants.dart';
import '../../../../helpers/image_helper.dart';
import '../../../../helpers/pdf_helper.dart';
import 'pdf_preview.dart';
import '../../../../widgets/dialogs/image_full_screen.dart';

class AttachmentWidget extends StatelessWidget {
  final bool isPdf;
  String? imageUrl;
  String? pdfUrl;
  String? title;
  AttachmentWidget({
    required this.isPdf,
    this.imageUrl,
    this.pdfUrl,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Orientation or = MediaQuery.of(context).orientation;
    return !isPdf
        ? GestureDetector(
            onTap: () {
              imageFullScreen(context, ImageHelper.getValidUrl(imageUrl!));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: w * 0.09),
              width: w * 0.9,
              height: w * 0.5,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(APP_API + imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfVeiwer(
                        pdfUrl: PdfHelper.getValidPdfUrl(pdfUrl!),
                        title: title!),
                  ));
            },
            child: Directionality(
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
                      'assets/images/section_icon.svg',
                      width: w * 0.15,
                      height: or == Orientation.portrait ? h * 0.07 : h * 0.2,
                    ),
                    title: Text(
                      title!,
                      style: TextStyle(
                        fontSize: w * 0.04,
                      ),
                    ),
                    subtitle: Text(
                      'ملف',
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
