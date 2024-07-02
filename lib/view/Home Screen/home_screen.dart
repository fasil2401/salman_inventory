// import 'dart:developer';

import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/model/user_location_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/asset_paths.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/screen_id.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Direct%20Inventory%20Transfer%20Screen/direct_inventory_transfer_screen.dart';
import 'package:axolon_inventory_manager/view/Item%20Creation%20Screen/item_creation_screen.dart';
import 'package:axolon_inventory_manager/view/Loading%20Sheet%20Screen/loading_sheet_main.dart';
import 'package:axolon_inventory_manager/view/Home%20Screen/components/drawer.dart';
import 'package:axolon_inventory_manager/view/Home%20Screen/home_grid_tile.dart';
import 'package:axolon_inventory_manager/view/Home%20Screen/transcation_screen_items.dart';
import 'package:axolon_inventory_manager/view/In%20Transfer%20Screen/in_transfer_screen.dart';
import 'package:axolon_inventory_manager/view/Item%20Details%20Screen/item_details_screen.dart';
import 'package:axolon_inventory_manager/view/Out%20Transfer%20Screen/out_transfer_screen.dart';
import 'package:axolon_inventory_manager/view/Quality%20Control%20Screen/quality_control_screen.dart';
import 'package:axolon_inventory_manager/view/Recieve%20Screen/recieve_screen.dart';
import 'package:axolon_inventory_manager/view/Stock%20Take%20Screen/stock_take_screen.dart';
import 'package:axolon_inventory_manager/view/Synchronisation%20Screen/sync_screen.dart';
// import 'package:axolon_inventory_manager/view/draft_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (UserSimplePreferences.getLocationId() == null ||
          UserSimplePreferences.getLocationId() == '') {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 15),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => CommonWidgets.textField(context,
                            suffixicon: true,
                            controller: TextEditingController(
                                text: homeController.userLocation.value.name ??
                                    ''), ontap: () {
                          homeController.getUserLocationList();
                          CommonWidgets.commonDialog(context, 'User Location',
                              GetBuilder<HomeController>(
                            builder: (_) {
                              return _.isLocationLoading.value
                                  ? CommonWidgets.popShimmer()
                                  : ListView.builder(
                                      itemCount: _.userLocationList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (ctx, index) {
                                        UserLocationModel item =
                                            _.userLocationList[index];
                                        return CommonWidgets.commonListTile(
                                            context: context,
                                            code: item.code ?? '',
                                            name: item.name ?? '',
                                            onPressed: () {
                                              homeController
                                                  .setUserLocation(item);
                                              Navigator.pop(context);
                                            });
                                      });
                            },
                          ));
                        },
                            readonly: true,
                            label: 'Select Location',
                            keyboardtype: TextInputType.text)),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.maxFinite,
                      child: Obx(() => CommonWidgets.elevatedButton(context,
                          onTap: homeController.userLocation.value.code == null
                              ? () {}
                              : () {
                                  Get.off(() => SyncScreen());
                                },
                          isDisabled:
                              homeController.userLocation.value.code == null,
                          type: ButtonTypes.Primary,
                          text: 'Continue',
                          isLoading: false)),
                    ),
                  ],
                ),
              );
            });
      }
    });
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 47,
        title: SizedBox(
          height: 30,
          child: Image.asset(
            Images.logo,
            fit: BoxFit.contain,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: HomeScreenDrawer(),
      body: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Warehouse Location:  ',
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    color: mutedColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Flexible(
                  child: UserSimplePreferences.getLocation() != null
                      ? Text(
                          UserSimplePreferences.getLocation() ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            color: commonBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : Obx(() => Text(
                            homeController.userLocation.value.name ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              color: commonBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: ListView(physics: ScrollPhysics(), children: [
          SizedBox(
            height: 19,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => HomeGridTile(
                      title: 'Item Details',
                      image: AppIcons.page,
                      onTap: () {
                        Get.to(() => ItemDetailsScreen());
                      },
                      isAdmin: homeController.user.value.isAdmin,
                      isScreenRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isScreenRightAvailable(
                                  screenId: TransactionScreenId.itemDetails,
                                  type: ScreenRightOptions.View)
                              : false,
                      isUserRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isUserRightAvailable(
                                  TransactionScreenItems.itemDetails)
                              : false,
                    )),
                Obx(() => HomeGridTile(
                      title: 'In-Transfer',
                      image: AppIcons.inTransfer,
                      onTap: () {
                        Get.to(() => InTransferScreen());
                      },
                      isAdmin: homeController.user.value.isAdmin,
                      isScreenRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isScreenRightAvailable(
                                  screenId: TransactionScreenId.inTransfer,
                                  type: ScreenRightOptions.View)
                              : false,
                      isUserRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isUserRightAvailable(
                                  TransactionScreenItems.inTransfer)
                              : false,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => HomeGridTile(
                      title: 'Out Transfer',
                      image: AppIcons.outTransfer,
                      onTap: () {
                        Get.to(() => OutTransferScreen());
                      },
                      isAdmin: homeController.user.value.isAdmin,
                      isScreenRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isScreenRightAvailable(
                                  screenId: TransactionScreenId.outTransfer,
                                  type: ScreenRightOptions.View)
                              : false,
                      isUserRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isUserRightAvailable(
                                  TransactionScreenItems.outTransfer)
                              : false,
                    )),
                Obx(() => HomeGridTile(
                    title: 'Recieve',
                    image: AppIcons.recieve,
                    onTap: () {
                      Get.to(() => RecieveScreen());
                    },
                    isAdmin: homeController.user.value.isAdmin,
                    isScreenRightAvailable: homeController.user.value.isAdmin ==
                            false
                        ? homeController.isScreenRightAvailable(
                            screenId: TransactionScreenId.recieve,
                            type: ScreenRightOptions.View)
                        : false,
                    isUserRightAvailable:
                        homeController.user.value.isAdmin == false
                            ? homeController.isUserRightAvailable(
                                TransactionScreenItems.recieve)
                            : false))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => HomeGridTile(
                    title: 'Stock Take',
                    image: AppIcons.stockTake,
                    onTap: () {
                      Get.to(() => StockTakeScreen());
                    },
                    isAdmin: homeController.user.value.isAdmin,
                    isScreenRightAvailable: 
                    homeController.user.value.isAdmin == false
                        ? homeController.isScreenRightAvailable(
                            screenId: TransactionScreenId.stockTake,
                            type: ScreenRightOptions.View)
                        : false,
                    isUserRightAvailable: 
                    homeController.user.value.isAdmin == false
                        ? homeController.isUserRightAvailable(
                            TransactionScreenItems.stockTake)
                        : false,
                    )),
                Obx(() => HomeGridTile(
                      title: 'Quarantine Transfer',
                      image: AppIcons.stock_rotation,
                      onTap: () {
                        Get.to(() => DirectInventroyTransferScreen());
                      },
                      isAdmin: homeController.user.value.isAdmin,
                      isScreenRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isScreenRightAvailable(
                                  screenId: TransactionScreenId.quarantine,
                                  type: ScreenRightOptions.View)
                              : false,
                      isUserRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isUserRightAvailable(
                                  TransactionScreenItems.quarantine)
                              : false,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => HomeGridTile(
                      title: 'Quality Control',
                      image: AppIcons.qc,
                      onTap: () {
                        Get.to(() => QualityControlScreen());
                      },
                      isAdmin: homeController.user.value.isAdmin,
                      isScreenRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isScreenRightAvailable(
                                  screenId: TransactionScreenId.qC,
                                  type: ScreenRightOptions.View)
                              : false,
                      isUserRightAvailable: homeController.user.value.isAdmin ==
                              false
                          ? homeController
                              .isUserRightAvailable(TransactionScreenItems.qC)
                          : false,
                    )),
                Obx(() => HomeGridTile(
                      title: 'Loading Sheet',
                      image: AppIcons.dock,
                      onTap: () {
                        Get.to(() => LoadingSheetMainScreen());
                      },
                      isAdmin: homeController.user.value.isAdmin,
                      isScreenRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isScreenRightAvailable(
                                  screenId: TransactionScreenId.loadingSheet,
                                  type: ScreenRightOptions.View)
                              : false,
                      isUserRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isUserRightAvailable(
                                  TransactionScreenItems.loadingSheet)
                              : false,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => HomeGridTile(
                      title: 'Item Creation',
                      image: AppIcons.page,
                      onTap: () {
                        Get.to(() => ItemCreationScreen());
                      },
                      isAdmin: homeController.user.value.isAdmin,
                      isScreenRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isScreenRightAvailable(
                                  screenId: TransactionScreenId.itemDetails,
                                  type: ScreenRightOptions.Add)
                              : false,
                      isUserRightAvailable:
                          homeController.user.value.isAdmin == false
                              ? homeController.isUserRightAvailable(
                                  TransactionScreenItems.itemDetails)
                              : false,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 35,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ]))
      ]),
    );
  }
}
