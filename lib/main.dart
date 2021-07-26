import 'dart:io';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teachers_app/screens/auth/splash_screen.dart';
import 'package:teachers_app/screens/home/home_screen.dart';
import 'package:teachers_app/services/notification_services.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  await GetStorage.init();
  //GetStorage().erase();
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());
  if (Platform.isAndroid) {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAGSECURE);
    await Firebase.initializeApp();
  }

  runApp(
    Phoenix(
      child: DevicePreview(
        enabled: false,
        builder: (context) => ProviderScope(child: MyApp()), // Wrap your app
      ),
    ),
  );
}
// void main() => ProviderScope(child: MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      NotificationService.init(context);
    }

    return MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,
      title: 'Teacher App Demo',
      theme: ThemeData(
        fontFamily: 'Cairo',
        primarySwatch: Colors.blue,
      ),
      //home: WelcomScreen(),
      routes: {
        '/': () => HomeScreen(),
      },
    );
  }
}
