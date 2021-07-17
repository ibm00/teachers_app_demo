import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teachers_app/constants.dart';
import 'package:teachers_app/providers/loading_provider.dart';
import 'package:teachers_app/providers/start_app_logic_provider.dart';
import 'package:teachers_app/screens/auth/welcom_screen.dart';
import 'package:teachers_app/screens/home/home_screen.dart';
import 'package:teachers_app/widgets/dialogs/quiz_buttons_dialogs.dart';
import 'package:teachers_app/widgets/loading.dart';

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<StateController<bool>>(
      provider: loadingProvider,
      onChange: (context, loading) {
        // trigger loading from any where in the project
        //just from any where call context.read(loadingProvider).state = true ;

        if (loading.state) {
          LoadingWidgets.getDialogLoading(context);
        } else {
          Navigator.pop(context);
        }
      },
      child: Consumer(
        builder: (context, watch, child) {
          final waitingStartLogicToDone = watch(startAppLogicProvider);
          return waitingStartLogicToDone.when(
            data: (logicResult) {
              switch (logicResult) {
                case UserStatus.disActive:
                  return Container();

                case UserStatus.loggedFather:
                  // Father home screen
                  return HomeScreen();

                case UserStatus.loggedStudent:
                  return HomeScreen();

                default:
                  return WelcomScreen();
              }
            },
            loading: () => SplashScreen(),
            error: (error, stackTrace) {
              print('this is start app logic error :$error');
              return SplashScreen();
            },
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: FlutterLogo(
          size: MediaQuery.of(context).size.width / 2,
        ),
      )),
    );
  }
}
