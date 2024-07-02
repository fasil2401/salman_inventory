import 'package:axolon_inventory_manager/controller/App%20Controls/package_info_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/splash_screen_controller.dart';
import 'package:axolon_inventory_manager/utils/constants/asset_paths.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final packageInfoCOntroller = Get.put(PackageInfoController());

  final splashScreenController = Get.put(SplashScreenController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: width * 0.9,
              child: Image.asset(
                Images.logo_gif,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Text(
                      'version :${packageInfoCOntroller.version.value}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.mutedColor,
                      ),
                    ),
                  ),
                  Text(
                    'License :Evaluation',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.mutedColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
