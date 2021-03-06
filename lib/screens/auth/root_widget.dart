import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../../providers/loading_provider.dart';
import '../../providers/start_app_logic_provider.dart';
import '../../widgets/loading.dart';
import '../father/father_home.dart';
import '../home/home_screen.dart';
import 'splash_screen.dart';
import 'disactive_screen.dart';
import 'welcom_screen.dart';

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<StateController<bool>>(
      provider: loadingProvider,
      onChange: (context, loading) {
        // trigger loading from any where in the project
        //just from any where call context.read(loadingProvider).state = true ;
        // and for sure don't forget to make it false to stop it
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
                  return DisActiveScreen();

                case UserStatus.loggedFather:
                  // Father home screen
                  return FatherHomeScreen();

                case UserStatus.loggedStudent:
                  return HomeScreen();
                case UserStatus.noInternet:
                  return SplashScreen();
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
