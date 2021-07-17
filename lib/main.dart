import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/providers/loading_provider.dart';
import 'package:teachers_app/screens/auth/login_screen.dart';
import 'package:teachers_app/screens/auth/splash_screen.dart';
import 'package:teachers_app/screens/home/home_screen.dart';
import 'package:teachers_app/screens/quiz/1-quiz_home/quiz_home.dart';
import 'package:teachers_app/widgets/dialogs/quiz_buttons_dialogs.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'screens/home/profile/profile_screen.dart';
import 'screens/quiz/take_quiz.dart';

void main() {
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
        '/': (_) => RootWidget(),
      },
    );
  }
}
