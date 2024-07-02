import 'package:axolon_inventory_manager/utils/Routes/route_manger.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    enterApp();
  }

  enterApp() async {
    String isConnected = UserSimplePreferences.getConnection() ?? 'false';
    String isLoggedIn = UserSimplePreferences.getLogin() ?? 'false';
    await Future.delayed(Duration(seconds: 4), () {
      if (isConnected == 'true') {
        if (isLoggedIn == 'true') {
          Get.offNamed(RouteManager.homeScreen);
        } else {
          Get.offNamed(RouteManager.loginScreen);
        }
      } else {
        Get.offNamed(RouteManager.connectionScreen);
      }
    });
  }
}
