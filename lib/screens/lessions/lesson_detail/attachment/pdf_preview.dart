import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../constants.dart';

class PdfVeiwer extends StatelessWidget {
  final String pdfUrl;
  final String title;
  const PdfVeiwer({
    required this.pdfUrl,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.download_rounded),
                onPressed: () async {
                  // await GeneralServices.downloadFile(url, title);
                })
          ],
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(title),
        ),
        body: SfPdfViewer.network(pdfUrl));
  }
}
