import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../constants.dart';

class PdfVeiwer extends StatelessWidget {
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
          title: Text('hhh'),
        ),
        body: Container(
            child: SfPdfViewer.network(
                'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')));
  }
}
