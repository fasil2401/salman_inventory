import 'package:axolon_inventory_manager/view/Connection%20Screen/connection_screen.dart';
import 'package:axolon_inventory_manager/view/Home%20Screen/home_screen.dart';
import 'package:axolon_inventory_manager/view/Login%20Screen/login_screen.dart';
import 'package:axolon_inventory_manager/view/Splash%20Screen/splash_screen.dart';
import 'package:get/get.dart';

class RouteManager {
  static const String splashScreen = '/splash';
  static const String homeScreen = '/home';
  static const String connectionScreen = '/connection';
  static const String loginScreen = '/login';
  List<GetPage> _routes = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      transition: Transition.cupertino,
    ),
     GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: connectionScreen,
      page: () => ConnectionScreen(),
      transition: Transition.cupertino,
    ),
  ];

  get routes => _routes;
}
