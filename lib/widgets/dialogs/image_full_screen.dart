import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

Future imageFullScreen(BuildContext context, String url) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext context, Animation first, Animation second) {
      return SafeArea(
        child: Material(
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Image.network(url),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: Icon(
                      Icons.download_sharp,
                      color: kSecondaryColor,
                    ),
                    onPressed: () async {
                      //  await GeneralServices.downloadImage(url);
                    }),
              ),
            ],
          ),
        ),
      );
    },
  );
}
