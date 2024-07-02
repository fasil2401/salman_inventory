import 'package:axolon_inventory_manager/services/Db%20Helper/db_helper.dart';
import 'package:axolon_inventory_manager/services/Themes/app_theme.dart';
import 'package:axolon_inventory_manager/services/Themes/custom_theme.dart';
import 'package:axolon_inventory_manager/utils/Routes/route_manger.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().database;
  await UserSimplePreferences.init();
  String themeKey = UserSimplePreferences.getTheme() ?? MyThemes.blueTheme;
  runApp(CustomTheme(
    initialThemeKey: themeKey,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Inventory Management',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.of(context),
      initialRoute: RouteManager.splashScreen,
      getPages: RouteManager().routes,
    );
  }
}
