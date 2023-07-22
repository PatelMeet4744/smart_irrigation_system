import 'package:smart_irrigation_app/route/routing_constants.dart';
import 'package:smart_irrigation_app/screens/dashboard_screen.dart';
import 'package:smart_irrigation_app/screens/signin_screen.dart';
import 'package:smart_irrigation_app/screens/signup_screen.dart';
import 'package:smart_irrigation_app/screens/splash_screen.dart';
import 'package:smart_irrigation_app/screens/undefined_screen.dart';
import 'package:smart_irrigation_app/screens/splash_screen_second.dart';
import 'package:smart_irrigation_app/screens/demo.dart';
import 'package:smart_irrigation_app/screens/home_page.dart';
import 'package:smart_irrigation_app/screens/Setting_screen.dart';
import 'package:smart_irrigation_app/screens/Motor_On_Off_Screen.dart';
import 'package:smart_irrigation_app/screens/auto_manuak.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreenRoute:
      return MaterialPageRoute(builder: (context) => SplashScreen());

    case SignInScreenRoute:
      return MaterialPageRoute(builder: (context) => SignInScreen());

    case SignUpScreenRoute:
      return MaterialPageRoute(builder: (context) => SignUpScreen());

    case DashboardScreenRoute:
      return MaterialPageRoute(builder: (context) => DashboardScreen());

    case SplashScreen2Route:
      return MaterialPageRoute(builder: (context) => SplashScreen2());

    case DemoScreenRoute:
      return MaterialPageRoute(builder: (context) => Demo());

    case HomeScreenRotue:
      return MaterialPageRoute(builder: (context) => HomePage());

    case SettingScreenRoute:
      return MaterialPageRoute(builder: (context) => SettingScreen());

    case MotorScreenRoute:
      return MaterialPageRoute(builder: (context) => MotorScreen());

    case AutoScreenRoute:
      return MaterialPageRoute(builder: (context) => AutoScreen());

    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name!,
              ));
  }
}
