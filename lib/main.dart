import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teachers_app/screens/home/home_screen.dart';
import 'package:teachers_app/screens/lessions/lesson_home.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'screens/lessions/lesson_detail/attachment/pdf_preview.dart';

Future<void> main() async {
  await GetStorage.init();
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => ProviderScope(child: MyApp()), // Wrap your app
    ),
  );
}
// void main() => ProviderScope(child: MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        '/': (_) => LessionsHomeScreen(),
      },
    );
  }
}
