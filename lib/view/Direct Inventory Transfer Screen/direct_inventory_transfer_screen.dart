import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/direct_inventory_transfer_controller.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/model/tansfer_type_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/Calculations/date_range_selector.dart';
import 'package:axolon_inventory_manager/utils/constants/asset_paths.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Components/dragging_button.dart';
import 'package:axolon_inventory_manager/view/Direct%20Inventory%20Transfer%20Screen/add_item_popup.dart';
import 'package:axolon_inventory_manager/view/Direct%20Inventory%20Transfer%20Screen/direct_transfer_item_list.dart';
import 'package:axolon_inventory_manager/view/Out%20Transfer%20Screen/add_item_popup.dart';
import 'package:axolon_inventory_manager/view/Out%20Transfer%20Screen/out_transfer_item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class DirectInventroyTransferScreen extends StatelessWidget {
  DirectInventroyTransferScreen({super.key});
  final directInventoryTransferController =
      Get.put(DirectInventoryTransferController());
  var selectedSysdocValue;
  double _height = 50.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Quarantine Transfer"),
        actions: [
          IconButton(
            onPressed: () {
              directInventoryTransferController
                  .getDirectInventoryTransferList();
              CommonWidgets.commonDialog(
                context,
                "",
                _buildOpenListPopContent(context),
              );
            },
            icon: Obx(
              () => directInventoryTransferController.isLoadingOpenList.value
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                        strokeWidth: 2,
                      ),
                    )
                  : SvgPicture.asset(
                      AppIcons.openList,
                      color: Colors.white,
                      width: 20,
                      height: 20,
                    ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() => CommonWidgets.textField(
                              context,
                              suffixicon: true,
                              readonly: true,
                              keyboardtype: TextInputType.text,
                              ontap: () {
                                CommonWidgets.commonDialog(
                                    context,
                                    'System Doccuments',
                                    ListView.separated(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          SysDocModel item =
                                              directInventoryTransferController
                                                  .sysDocList[index];
                                          return CommonWidgets.commonListTile(
                                              context: context,
                                              code: item.code ?? '',
                                              name: item.name ?? '',
                                              onPressed: () {
                                                directInventoryTransferController
                                                    .selectSyDoc(index);
                                                Navigator.pop(context);
                                              });
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              height: 8,
                                            ),
                                        itemCount:
                                            directInventoryTransferController
                                                .sysDocList.length));
                              },
                              controller: TextEditingController(
                                  text:
                                      '${directInventoryTransferController.selectedSysDoc.value.code ?? ""} - ${directInventoryTransferController.selectedSysDoc.value.name ?? ""}'),
                              label: 'SysDocId',
                              onchanged: (value) {},
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Voucher : ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary),
                      ),
                      Obx(() => Text(
                            directInventoryTransferController
                                .voucherNumber.value,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primary),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(() => InkWell(
                    onTap: () {
                      directInventoryTransferController.openAccordian();
                    },
                    child: GFAccordion(
                      margin: EdgeInsets.all(0),
                      showAccordion: directInventoryTransferController
                          .isOpenAccordian.value,
                      expandedIcon: Icon(Icons.keyboard_arrow_up_outlined,
                          color: AppColors.white),
                      collapsedIcon: Icon(Icons.keyboard_arrow_down_outlined,
                          color: AppColors.white),
                      contentBorder: Border.all(
                        color: AppColors.primary,
                      ),
                      expandedTitleBackgroundColor: AppColors.primary,
                      contentBorderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                      titleBorderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      title: "Transfer Details",
                      textStyle: TextStyle(color: AppColors.white),
                      collapsedTitleBackgroundColor: AppColors.mutedColor,
                      //     content: "Transfer Details",
                      contentChild: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CommonWidgets.textField(
                            context,
                            suffixicon: false,
                            readonly: true,
                            keyboardtype: TextInputType.datetime,
                            controller: TextEditingController(
                                text: DateFormatter.dateFormat.format(
                                    directInventoryTransferController
                                        .selectedDate.value)),
                            label: 'Date',
                            ontap: () async {
                              DateTime newDate =
                                  await CommonWidgets.getCalender(
                                          context,
                                          directInventoryTransferController
                                              .selectedDate.value) ??
                                      DateTime.now();
                              directInventoryTransferController
                                  .selectDates(newDate);
                            },
                            onchanged: (value) {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CommonWidgets.textField(
                            context,
                            suffixicon: true,
                            readonly: true,
                            keyboardtype: TextInputType.datetime,
                            controller: TextEditingController(
                                text:
                                    '${directInventoryTransferController.selectedLocation.value.code ?? ''} - ${directInventoryTransferController.selectedLocation.value.name ?? ''}'),
                            label: 'Quarantine Location',
                            ontap: () {
                              CommonWidgets.commonDialog(
                                  context,
                                  'Quarantine Location',
                                  ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        LocationModel item =
                                            directInventoryTransferController
                                                .locationList[index];
                                        return CommonWidgets.commonListTile(
                                            context: context,
                                            code: item.code ?? '',
                                            name: item.name ?? '',
                                            onPressed: () {
                                              directInventoryTransferController
                                                  .selectLocation(index);
                                              Navigator.pop(context);
                                            });
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 8,
                                          ),
                                      itemCount:
                                          directInventoryTransferController
                                              .locationList.length));
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CommonWidgets.textField(context,
                              suffixicon: false,
                              readonly: false,
                              keyboardtype: TextInputType.text,
                              label: "Reference",
                              controller: directInventoryTransferController
                                  .referencecontroller.value,
                              ontap: () {}),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ))),
                SizedBox(
                  height: 30,
                ),
                // Flexible(
                //   child: CommonWidgets.textField(
                //     context,
                //     suffixicon: false,
                //     expands:
                //         directInventoryTransferController.shouldExpand.value,
                //     maxLines: null,
                //     readonly: false,
                //     onChanged: (text) {
                //       directInventoryTransferController.updateHeight();
                //     },
                //     keyboardtype: TextInputType.text,
                //     label: "Note",
                //     controller:
                //         directInventoryTransferController.notecontroller.value,
                //   ),
                // ),
                Flexible(
                    child: TextFormField(
                  controller:
                      directInventoryTransferController.notecontroller.value,
                  style: TextStyle(fontSize: 12, color: mutedColor),
                  expands: directInventoryTransferController.shouldExpand.value,
                  maxLines: null,
                  onChanged: (text) {
                    directInventoryTransferController.updateHeight();
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    isCollapsed: true,
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: mutedColor, width: 0.1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: mutedColor, width: 0.1),
                    ),
                    labelText: "Note",
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Inventory",
                  style: TextStyle(color: AppColors.mutedColor, fontSize: 15),
                ),
                Divider(
                  color: AppColors.mutedColor,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 10,
                ),
                _buildHeader(
                  context,
                ),
                SizedBox(
                  height: 10,
                ),
                Obx(() {
                  // inventoryItemLocalListController.getInventory();
                  return directInventoryTransferController
                          .inventoryItemList.isEmpty
                      ? const Center(
                          child: Text(
                            "No Data. Click add button to add details",
                            style: TextStyle(color: AppColors.mutedColor),
                          ),
                        )
                      : Expanded(
                          child: GetBuilder<DirectInventoryTransferController>(
                            builder: (_) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: _.inventoryItemList.length,
                                itemBuilder: (context, index) {
                                  var item = _.inventoryItemList[index];
                                  return Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Slidable(
                                          key: const Key('inventory_items'),
                                          startActionPane: ActionPane(
                                            motion: const DrawerMotion(),
                                            children: [
                                              SlidableAction(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  foregroundColor: Colors.green,
                                                  icon:
                                                      Icons.mode_edit_outlined,
                                                  onPressed: (_) {
                                                    log("${item.updatedQuantity} length");

                                                    // directInventoryTransferController. productUnitList.value = item.unitList ?? [];
                                                    directInventoryTransferController
                                                        .getDataToUpdate(
                                                            item,
                                                            item.unitList ??
                                                                []);
                                                    CommonWidgets.commonDialog(
                                                        context,
                                                        "${item.product?.description ?? ''}",
                                                        DirectInventoryAddUpdateItem(
                                                          units:
                                                              item.unitList ??
                                                                  [],
                                                          isUpdate: true,
                                                        ),
                                                        actions: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: CommonWidgets
                                                                    .elevatedButton(
                                                                  context,
                                                                  onTap: () {
                                                                    directInventoryTransferController
                                                                        .updateItem(
                                                                      index,
                                                                    );
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  type: ButtonTypes
                                                                      .Primary,
                                                                  text:
                                                                      "Update",
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ]);
                                                  })
                                            ],
                                          ),
                                          endActionPane: ActionPane(
                                            motion: const DrawerMotion(),
                                            children: [
                                              SlidableAction(
                                                backgroundColor:
                                                    Colors.transparent,
                                                foregroundColor: Colors.red,
                                                icon: Icons.delete,
                                                onPressed: (_) =>
                                                    directInventoryTransferController
                                                        .deleteItem(index),
                                              ),
                                            ],
                                          ),
                                          child: GestureDetector(
                                              onDoubleTap: () {
                                                // itemDetailsController
                                                //     .updateValuesFromInventory(
                                                //         directInventoryTransferController
                                                //             .inventoryItemList[index]
                                                //             .productId);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: _buildRows(context,
                                                    code:
                                                        "${item.product?.productId ?? ''}",
                                                    name:
                                                        "${item.product?.description ?? ''}",
                                                    unit:
                                                        "${item.updatedUnit?.code ?? ""}",
                                                    qunatity:
                                                        "${item.updatedQuantity ?? 0}",
                                                    isHeader: false),
                                              ))));
                                },
                              );
                            },
                          ),
                        );
                }),
              ],
            ),
          ),
          DragableButton(
            key: const Key('direct_transfer'),
            onTap: () {
              Get.to(() => DirectInventoryTransferItemListScreen());
              directInventoryTransferController.getProductList();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CommonWidgets.elevatedButton(context, onTap: () async {
                final isConfirm = await showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    title: new Text('Are you sure?',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold)),
                    content: new Text(
                        'Do you want to close Transfer ? This actioln will clear current data'),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    actions: <Widget>[
                      InkWell(
                          onTap: () => Navigator.of(context).pop(false),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Cancel',
                                style: TextStyle(
                                    color: Theme.of(context).backgroundColor,
                                    fontWeight: FontWeight.bold)),
                          )),
                      InkWell(
                          onTap: () => Navigator.of(context).pop(true),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Okay',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold)),
                          )),
                    ],
                  ),
                );
                if (isConfirm) {
                  Get.delete<DirectInventoryTransferController>();
                  // Get.back();
                  Navigator.pop(context);
                }
              }, type: ButtonTypes.Secondary, text: 'Cancel', isLoading: false),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Obx(() =>
                  //  directInventoryTransferController.isLoading.value
                  //     ? CircularProgressIndicator(
                  //         strokeWidth: 2,
                  //         color: Colors.white,
                  //       )
                  //     :
                  CommonWidgets.elevatedButton(context, onTap: () {
                    directInventoryTransferController
                        .createDirectinventoryTransfer();
                    // for (var item in directInventoryTransferController
                    //     .inventoryItemList[0].availableLots!) {
                    //  log("${item.acceptedQuantiy}acceptedQuantiy");
                    // }
                  },
                      type: ButtonTypes.Primary,
                      text: 'Save',
                      isLoading:
                          directInventoryTransferController.isSaving.value)),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: _buildRows(context,
            code: 'Code',
            name: 'Name',
            unit: "Unit",
            qunatity: "Qty",
            isHeader: true),
      ),
    );
  }

  SizedBox _buildOpenListPopContent(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          _buildOpenListHeader(context),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => directInventoryTransferController.isLoadingOpenList.value
                    ? CommonWidgets.popShimmer()
                    : directInventoryTransferController
                            .directinventorytransferOpenList.isEmpty
                        ? Center(
                            child: Text('No Data Found'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: directInventoryTransferController
                                .directinventorytransferOpenList.length,
                            itemBuilder: (context, index) {
                              var item = directInventoryTransferController
                                  .directinventorytransferOpenList[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 3,
                                child: InkWell(
                                  splashColor: mutedColor.withOpacity(0.2),
                                  splashFactory: InkRipple.splashFactory,
                                  onTap: () async {
                                    Navigator.pop(context);
                                    await directInventoryTransferController
                                        .getDirectinventoryTransferById(
                                            item.sysDocId ?? "",
                                            item.voucherId ?? "");
                                    log("${item.voucherId}  item.voucherId");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                '${item.sysDocId} - ${item.voucherId}',
                                                minFontSize: 12,
                                                maxFontSize: 18,
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              '${item.locationFromId}-${item.locationToId}',
                                              minFontSize: 12,
                                              maxFontSize: 18,
                                              style: TextStyle(
                                                color: AppColors.mutedColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        AutoSizeText(
                                          'Date : ${DateFormatter.dateFormat.format(item.transactionDate!)}',
                                          minFontSize: 12,
                                          maxFontSize: 18,
                                          style: TextStyle(
                                            color: AppColors.mutedColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildOpenListHeader(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => CommonWidgets.commonDateFilter(
                context,
                directInventoryTransferController.dateIndex.value,
                directInventoryTransferController.isToDate.value,
                directInventoryTransferController.isFromDate.value,
                directInventoryTransferController.fromDate.value,
                directInventoryTransferController.toDate.value, (value) {
              selectedSysdocValue = value;
              directInventoryTransferController.selectDateRange(
                  selectedSysdocValue.value,
                  DateRangeSelector.dateRange.indexOf(selectedSysdocValue));
            },
                () => directInventoryTransferController.selectDate(context,
                    directInventoryTransferController.isFromDate.value))),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              directInventoryTransferController
                  .getDirectInventoryTransferList();
              // Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Apply',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: 'Rubik',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildRows(BuildContext context,
      {required String code,
      required String name,
      required String unit,
      required String qunatity,
      required bool isHeader}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            code,
            style: TextStyle(
              fontSize: 14,
              color: isHeader
                  ? Theme.of(context).primaryColor
                  : AppColors.mutedColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Expanded(
          flex: 3,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 14,
              color: isHeader
                  ? Theme.of(context).primaryColor
                  : AppColors.mutedColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            unit,
            style: TextStyle(
              fontSize: 14,
              color: isHeader
                  ? Theme.of(context).primaryColor
                  : AppColors.mutedColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              qunatity,
              style: TextStyle(
                fontSize: 14,
                color: isHeader
                    ? Theme.of(context).primaryColor
                    : AppColors.mutedColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget chatTextField({
  required TextEditingController controller,
  required String label,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      maxLines:
          null, // Setting maxLines to null allows the text field to expand
      minLines: 1, // Minimum number of lines
      expands: true, // Allows the text field to expand as the user types
    ),
  );
}
