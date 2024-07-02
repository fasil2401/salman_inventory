import 'dart:convert';
import 'dart:typed_data';

import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/model/user_location_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/Routes/route_manger.dart';
import 'package:axolon_inventory_manager/utils/constants/asset_paths.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Home%20Screen/components/settings.dart';
import 'package:axolon_inventory_manager/view/Report%20Screen/report_screen.dart';
import 'package:axolon_inventory_manager/view/Synchronisation%20Screen/sync_screen.dart';
import 'package:axolon_inventory_manager/view/stoke%20take%20report/stoke_take_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreenDrawer extends StatelessWidget {
  HomeScreenDrawer({
    super.key,
  });
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(children: [
              Container(
                color: commonBlueColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Row(
                    children: [
                      Obx(() {
                        Uint8List bytes = Base64Codec()
                            .decode(homeController.userImage.value);
                        return CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          child: homeController.userImage.value == ''
                              ? CircleAvatar(
                                  backgroundColor: commonBlueColor,
                                  radius: 35,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      'assets/images/user.png',
                                      fit: BoxFit.cover,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundColor: commonBlueColor,
                                  radius: 35,
                                  backgroundImage: MemoryImage(bytes),
                                ),
                        );
                      }),
                      SizedBox(width: MediaQuery.of(context).size.width / 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              UserSimplePreferences.getUsername() ?? "",
                              // 'VAN CASH',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // if (UserSimplePreferences.batchID.value != null &&
              //     UserSimplePreferences.batchID.value <= 0)
              SizedBox(
                height: 20,
              ),

              Column(
                children: [
                  Column(
                    children: [
                      DrawerTile(
                        title: 'Location',
                        icon: Images.searchlocation,
                        onTap: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  insetPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Obx(() => CommonWidgets.textField(context,
                                              suffixicon: true,
                                              controller: TextEditingController(
                                                  text: homeController
                                                          .userLocation
                                                          .value
                                                          .name ??
                                                      ''), ontap: () {
                                            homeController
                                                .getUserLocationList();
                                            CommonWidgets.commonDialog(
                                                context, 'User Location',
                                                GetBuilder<HomeController>(
                                              builder: (_) {
                                                return _.isLocationLoading.value
                                                    ? CommonWidgets.popShimmer()
                                                    : ListView.builder(
                                                        itemCount: _
                                                            .userLocationList
                                                            .length,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (ctx, index) {
                                                          UserLocationModel
                                                              item =
                                                              _.userLocationList[
                                                                  index];
                                                          return CommonWidgets
                                                              .commonListTile(
                                                                  context:
                                                                      context,
                                                                  code:
                                                                      item.code ??
                                                                          '',
                                                                  name:
                                                                      item.name ??
                                                                          '',
                                                                  onPressed:
                                                                      () {
                                                                    homeController
                                                                        .setUserLocation(
                                                                            item);
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                        });
                                              },
                                            ));
                                          },
                                              readonly: true,
                                              label: 'Select Location',
                                              keyboardtype:
                                                  TextInputType.text)),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        child: Obx(() =>
                                            CommonWidgets.elevatedButton(
                                                context,
                                                onTap: homeController
                                                            .userLocation
                                                            .value
                                                            .code ==
                                                        null
                                                    ? () {}
                                                    : () {
                                                        Get.off(
                                                            () => SyncScreen());
                                                      },
                                                isDisabled: homeController
                                                        .userLocation
                                                        .value
                                                        .code ==
                                                    null,
                                                type: ButtonTypes.Primary,
                                                text: 'Continue',
                                                isLoading: false)),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),
              DrawerTile(
                title: 'Synchronization',
                icon: Images.sync,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => SyncScreen());
                },
              ),
              SizedBox(
                height: 20,
              ),

              DrawerTile(
                title: 'Report',
                icon: Images.report,
                onTap: () {
                  Get.to(() => ReportScreen());
                },
              ),
              SizedBox(
                height: 20,
              ),
              DrawerTile(
                title: 'Stock Take Report',
                icon: Images.report,
                onTap: () {
                  Get.to(() => StockTakeReport());
                },
                //'assets/icons/drawer/privacy.svg',
              ),

              SizedBox(
                height: 20,
              ),
              DrawerTile(
                title: 'Privacy Policy',
                icon: Images.privacypolicy,
                onTap: () {},
              ),
              SizedBox(
                height: 20,
              ),
              DrawerTile(
                title: 'Settings',
                icon: Images.privacypolicy,
                onTap: () {
                  Get.to(() => SettingsScreen());
                },
              ),
              SizedBox(
                height: 20,
              ),
              DrawerTile(
                title: 'Logout',
                isRed: true,
                icon: Images.logout,
                onTap: () async {
                  Navigator.pop(context);
                  await UserSimplePreferences.setLogin('false');
                  await UserSimplePreferences.setLocationId('');
                  await UserSimplePreferences.setLocation('');
                  await UserSimplePreferences.setIsSyncCompleted(false);
                  Get.offAllNamed(RouteManager.loginScreen);
                },
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child:
                  // print(versionControl.version);
                  Text(
                'Version ${UserSimplePreferences.getVersion() ?? ''}',
                style: TextStyle(
                  color: mutedColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final String icon;
  final bool isRed;
  final bool isLoading;
  final VoidCallback onTap;
  const DrawerTile(
      {Key? key,
      required this.title,
      required this.icon,
      this.isRed = false,
      required this.onTap,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(AppColors.primary),
                        strokeWidth: 2,
                      ),
                    )
                  : SvgPicture.asset(
                      icon,
                      height: 25,
                      width: 25,
                      color: isRed == true
                          ? AppColors.redPrimary
                          : Theme.of(context).primaryColor,
                    ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.mutedColor,
                fontWeight: FontWeight.w400,
                fontFamily: 'Rubik',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
