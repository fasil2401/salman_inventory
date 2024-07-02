import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/loading_sheet_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/sync_controller.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/asset_paths.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/internet_check.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Home%20Screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen>
    with SingleTickerProviderStateMixin {
  final syncController = Get.put(SyncController());

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Synchronisation'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            color: AppColors.white,
            child: SizedBox(
              height: 60,
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.mutedColor,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(
                    text: 'In Sync',
                    icon: Icon(Icons.cloud_download_outlined),
                  ),
                  Tab(
                      text: 'Out Sync',
                      icon: Icon(Icons.cloud_upload_outlined)),
                ],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                String dbFilePath = join(await getDatabasesPath(),
                    "inventory.db"); //'/path/to/your/db/file.db3';
                shareDBFile(dbFilePath);
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInSync(context),
          _buildOutSync(context),
        ],
      ),
    );
  }

  Widget _buildOutSync(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  syncController.selectAllOut();
                },
                splashColor: lightGrey,
                splashFactory: InkRipple.splashFactory,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: mutedColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Obx(() => Icon(
                          Icons.check,
                          size: 15,
                          color: syncController.isAllSelectOut.value
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                        )),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              AutoSizeText(
                'Select All',
                minFontSize: 16,
                maxFontSize: 20,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: mutedColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          tableHeader(context),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => _buildSyncRow(
              context,
              isLoading: syncController.isLoadingInventoryTransfer.value,
              isSuccess: syncController.isInventoryTransferSuccess.value,
              isError: syncController.isErrorInventoryTransfer.value,
              isSyncing: syncController.isInventoryTransferSyncing.value,
              title: 'Inventory Transfer',
              onChanged: (value) {
                syncController.toggleInventoryTransfer(value);
              },
              toggleValue: syncController.inventoryTransferToggle.value,
              errorMsg: syncController.errorInventoryTransfer.value,
            ),
          ),
          Obx(
            () => _buildSyncRow(
              context,
              isLoading: syncController.isLoadingLoadingSheet.value,
              isSuccess: syncController.isLoadingSheetSuccess.value,
              isError: syncController.isErrorLoadingSheet.value,
              isSyncing: syncController.isLoadingSheetSyncing.value,
              title: 'Loading Sheet',
              onChanged: (value) {
                syncController.toggleLoadingSheet(value);
              },
              toggleValue: syncController.loadingSheetToggle.value,
              errorMsg: syncController.errorLoadingSheet.value,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidgets.elevatedButton(context, onTap: () async {
                InternetCheck.isInternetAvailable().then((value) {
                  if (value) {
                    syncController.startOutSync();
                  } else {
                    InternetCheck.showInternetToast(context);
                  }
                });
              },
                  type: ButtonTypes.Primary,
                  isLoading: false,
                  text: 'Start Sync'),
              // ElevatedButton(
              //   onPressed: () {
              //     // InternetCheck.isInternetAvailable().then((value) {
              //     //   if (value) {
              //     //     if (UserSimplePreferences.getBatchID() != null &&
              //     //         UserSimplePreferences.getBatchID()! > 0) {
              //     //       SnackbarServices.errorSnackbar(
              //     //           "Close the batch to Out Sync");
              //     //     } else {
              //     //       syncController.startOutSync();
              //     //     }
              //     //   } else {
              //     //     InternetCheck.showInternetToast(context);
              //     //   }
              //     // });
              //   },
              //   child: Text(
              //     'Start Sync',
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Theme.of(context).primaryColor,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //   ),
              // ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Sync Log',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              CommonWidgets.elevatedButton(context, onTap: () {
                if (syncController.checkOutSynced()) {
                  Get.off(() => HomeScreen());
                }
              },
                  type: ButtonTypes.Secondary,
                  isLoading: false,
                  text: 'Continue'),
              // ElevatedButton(
              //   onPressed: () {
              //     // Navigator.pop(context);
              //     // if (syncController.checkIsSynced()) {
              //     //   if (UserSimplePreferences.getBatchID() != null &&
              //     //       UserSimplePreferences.getBatchID()! > 0) {
              //     //     Navigator.pop(context);
              //     //   } else {
              //     //     Get.offAllNamed('/routeDetails');
              //     //   }
              //     // }

              //     // syncController.continueToHome();
              //   },
              //   child: Text(
              //     'Continue',
              //     style: TextStyle(
              //       color: Theme.of(context).primaryColor,
              //     ),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Theme.of(context).backgroundColor,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: double.infinity,
              child: CommonWidgets.elevatedButton(context, onTap: () {
                if (syncController.checkOutSynced()) {
                  Get.off(() => HomeScreen());
                }
              },
                  type: ButtonTypes.Primary,
                  isLoading: false,
                  text: 'Go to Home')),
        ],
      ),
    );
  }

  Widget _buildInSync(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  syncController.selectAllIn();
                },
                splashColor: lightGrey,
                splashFactory: InkRipple.splashFactory,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: mutedColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Obx(() => Icon(
                          Icons.check,
                          size: 15,
                          color: syncController.isAllSelectIn.value
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                        )),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              AutoSizeText(
                'Select All',
                minFontSize: 16,
                maxFontSize: 20,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: mutedColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          tableHeader(context),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => _buildSyncRow(
              context,
              isLoading: syncController.isLoadingUserSecurity.value,
              isSuccess: syncController.isUserSecuritySuccess.value,
              isError: syncController.isErrorUserSecurity.value,
              isSyncing: syncController.isUserSecuritySyncing.value,
              title: 'User Security',
              onChanged: (value) {
                syncController.toggleUserSecurity(value);
              },
              toggleValue: syncController.userSecurityToggle.value,
              errorMsg: syncController.errorUserSecurity.value,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => _buildSyncRow(
              context,
              isLoading: syncController.isLoadingTransferType.value,
              isSuccess: syncController.isTransferTypeSuccess.value,
              isError: syncController.isErrorTransferType.value,
              isSyncing: syncController.isTransferTypeSyncing.value,
              title: 'TransferType',
              onChanged: (value) {
                syncController.toggleTransferType(value);
              },
              toggleValue: syncController.transferTypeToggle.value,
              errorMsg: syncController.errorTransferType.value,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => _buildSyncRow(
              context,
              isLoading: syncController.isLoadingSystemDocId.value,
              isSuccess: syncController.isSystemDocIdSuccess.value,
              isError: syncController.isErrorSystemDocId.value,
              isSyncing: syncController.isSystemDocIdSyncing.value,
              title: 'System Document Id',
              onChanged: (value) {
                syncController.toggleSystemDocId(value);
              },
              toggleValue: syncController.systemDocIdToggle.value,
              errorMsg: syncController.errorSystemDocId.value,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => _buildSyncRow(
              context,
              isLoading: syncController.isLoadingLocations.value,
              isSuccess: syncController.isLocationsSuccess.value,
              isError: syncController.isErrorLocations.value,
              isSyncing: syncController.isLocationsSyncing.value,
              title: 'Locations',
              onChanged: (value) {
                syncController.toggleLocations(value);
              },
              toggleValue: syncController.locationsToggle.value,
              errorMsg: syncController.errorLocations.value,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => _buildSyncRow(
              context,
              isLoading: syncController.isLoadingCustomers.value,
              isSuccess: syncController.isCustomersSuccess.value,
              isError: syncController.isErrorCustomers.value,
              isSyncing: syncController.isCustomersSyncing.value,
              title: 'Customers',
              onChanged: (value) {
                syncController.toggleCustomers(value);
              },
              toggleValue: syncController.customersToggle.value,
              errorMsg: syncController.errorCustomers.value,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => _buildSyncRow(
              context,
              isLoading: syncController.isLoadingProductMasters.value,
              isSuccess: syncController.isProductMastersSuccess.value,
              isError: syncController.isErrorProductMasters.value,
              isSyncing: syncController.isProductMastersSyncing.value,
              title: 'Product Masters',
              onChanged: (value) {
                syncController.toggleProductMasters(value);
              },
              toggleValue: syncController.productMastersToggle.value,
              errorMsg: syncController.errorProductMasters.value,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidgets.elevatedButton(context, onTap: () {
                InternetCheck.isInternetAvailable().then((value) {
                  if (value) {
                    syncController.startInSync();
                  } else {
                    InternetCheck.showInternetToast(context);
                  }
                });
              },
                  type: ButtonTypes.Primary,
                  isLoading: false,
                  text: 'Start Sync'),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Sync Log',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              CommonWidgets.elevatedButton(context, onTap: () {
                if (syncController.checkIsSynced()) {
                  Get.off(() => HomeScreen());
                }
              },
                  type: ButtonTypes.Secondary,
                  isLoading: false,
                  text: 'Continue'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: double.infinity,
              child: CommonWidgets.elevatedButton(context, onTap: () {
                if (syncController.checkIsSynced()) {
                  Get.off(() => HomeScreen());
                }
              },
                  type: ButtonTypes.Primary,
                  isLoading: false,
                  text: 'Go to Home')),
        ],
      ),
    );
  }

  void shareDBFile(String filePath) {
    File file = File(filePath);
    if (file.existsSync()) {
      Share.shareFiles([filePath], text: 'Sharing .db3 file');
    } else {
      // Handle file not found error
      print('File not found');
    }
  }

  Row _buildSyncRow(
    BuildContext context, {
    required String title,
    required bool toggleValue,
    required Function(dynamic) onChanged,
    required bool isSyncing,
    required bool isLoading,
    required bool isSuccess,
    required bool isError,
    required String errorMsg,
  }) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: AutoSizeText(
              title,
              minFontSize: 14,
              maxFontSize: 18,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: mutedColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            width: 70,
            child: Center(
              child: Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  activeColor: Theme.of(context).primaryColor,
                  value: toggleValue,
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            width: 70,
            child: Center(
                child: isSyncing
                    ? isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                              strokeWidth: 2,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              if (isError)
                                SnackbarServices.errorSnackbar(errorMsg);
                            },
                            child: SvgPicture.asset(
                              isSuccess == true && isError == false
                                  ? AppIcons.check
                                  : AppIcons.cancel,
                              color: isSuccess == true && isError == false
                                  ? AppColors.darkGreen
                                  : AppColors.darkRed,
                              width: 20,
                              height: 20,
                            ),
                          )
                    : Container()),
          ),
        ),
      ],
    );
  }

  Container tableHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Data',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: 70,
                child: Text(
                  'Required',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                width: 70,
                child: Center(
                  child: Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
