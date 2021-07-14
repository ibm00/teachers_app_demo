import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/screens/home/profile/profile_screen.dart';
import 'screens/auth/register_screen/register_screen.dart';
import 'screens/auth/welcom_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/quiz/quiz_home/quiz_home.dart';

void main() => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => ProviderScope(child: MyApp()), // Wrap your app
      ),
    );
// void main() => ProviderScope(child: MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Cairo',
        primarySwatch: Colors.blue,
      ),
      //home: WelcomScreen(),
      routes: {
        '/': (_) => QuizHomeScreen(),
      },
    );
  }
}
