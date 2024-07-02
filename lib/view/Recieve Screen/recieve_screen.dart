import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/recieve_controller.dart';
import 'package:axolon_inventory_manager/model/get_vendor_combo_list_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/Calculations/date_range_selector.dart';
import 'package:axolon_inventory_manager/utils/constants/asset_paths.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Components/dragging_button.dart';
import 'package:axolon_inventory_manager/view/Recieve%20Screen/add_item_popup.dart';
import 'package:axolon_inventory_manager/view/Recieve%20Screen/recieve_item_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../model/Recieve Item Model/add_recieve_item_model.dart';
import '../../model/location_model.dart';
import '../../model/product_list_model.dart';
import '../../utils/constants/snackbar.dart';

class RecieveScreen extends StatelessWidget {
  RecieveScreen({super.key});

  final recieveController = Get.put(RecieveController());
  var selectedSysdocValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Goods Recieve Note"),
        actions: [
          IconButton(
            onPressed: () {
              recieveController.getRecieveReportOpenList();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    insetPadding: const EdgeInsets.all(10),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: _buildOpenListHeader(context),
                    content: SizedBox(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: _buildOpenListPopContent(context),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text('Close',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            icon: Obx(
              () => recieveController.isOpenListLoading.value
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
      body: GetBuilder<RecieveController>(builder: (controller) {
        return Stack(
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
                                            SysDocModel item = recieveController
                                                .sysDocList[index];
                                            return CommonWidgets.commonListTile(
                                                context: context,
                                                code: item.code ?? '',
                                                name: item.name ?? '',
                                                onPressed: () {
                                                  recieveController
                                                      .selectSyDoc(index);
                                                  Navigator.pop(context);
                                                });
                                          },
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: 8,
                                              ),
                                          itemCount: recieveController
                                              .sysDocList.length));
                                },
                                controller: TextEditingController(
                                    text:
                                        '${recieveController.selectedSysDoc.value.code} - ${recieveController.selectedSysDoc.value.name}'),
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
                              recieveController.voucherNumber.value,
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
                  Obx(() => CommonWidgets.textField(
                        context,
                        suffixicon: false,
                        readonly: true,
                        keyboardtype: TextInputType.datetime,
                        controller: TextEditingController(
                            text: DateFormatter.dateFormat
                                .format(recieveController.selectedDate.value)),
                        label: 'Date',
                        ontap: () async {
                          DateTime newDate = await CommonWidgets.getCalender(
                                  context,
                                  recieveController.selectedDate.value) ??
                              DateTime.now();
                          recieveController.selectDates(newDate);
                        },
                        onchanged: (value) {},
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() => CommonWidgets.textField(
                        context,
                        suffixicon: true,
                        readonly: true,
                        keyboardtype: TextInputType.datetime,
                        controller: TextEditingController(
                            text: recieveController.selectedVendor.value.code !=
                                    null
                                ? '${recieveController.selectedVendor.value.code} - ${recieveController.selectedVendor.value.name}'
                                : ''),
                        label: 'Vendor',
                        ontap: () {
                          CommonWidgets.commonDialog(
                              context,
                              'Vendors',
                              ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    VendorModel item =
                                        recieveController.vendorList[index];
                                    return CommonWidgets.commonListTile(
                                        context: context,
                                        code: item.code ?? '',
                                        name: item.name ?? '',
                                        onPressed: () {
                                          recieveController.selectVendor(index);
                                          Navigator.pop(context);
                                        });
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 8,
                                      ),
                                  itemCount:
                                      recieveController.vendorList.length));
                        },
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  CommonWidgets.textField(context,
                      suffixicon: false,
                      readonly: false,
                      keyboardtype: TextInputType.text,
                      label: 'Note',
                      controller: recieveController.note.value,
                      maxLength: null,
                      maxLines: null),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonWidgets.textField(context,
                            suffixicon: false,
                            readonly: false,
                            keyboardtype: TextInputType.number,
                            label: 'Reference 1',
                            controller: recieveController.ref1.value,
                            maxLength: null,
                            maxLines: null),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CommonWidgets.textField(context,
                            suffixicon: false,
                            readonly: false,
                            keyboardtype: TextInputType.number,
                            label: 'Reference 2',
                            controller: recieveController.ref2.value,
                            maxLength: null,
                            maxLines: null),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonWidgets.textField(context,
                            suffixicon: false,
                            readonly: false,
                            keyboardtype: TextInputType.number,
                            label: 'Vendor Ref',
                            controller: recieveController.vendorRef.value,
                            maxLength: null,
                            maxLines: null),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: CommonWidgets.textField(context,
                            suffixicon: false,
                            readonly: false,
                            keyboardtype: TextInputType.text,
                            label: 'Vehicle Name',
                            controller: recieveController.vehicleName.value,
                            maxLength: null,
                            maxLines: null),
                      ),
                    ],
                  ),

                  // Obx(() => InkWell(
                  //     onTap: () {
                  //       recieveController.openAccordian();
                  //     },
                  //     child: GFAccordion(
                  //       margin: EdgeInsets.all(0),
                  //       showAccordion: recieveController.isOpenAccordian.value,
                  //       expandedIcon: Icon(Icons.keyboard_arrow_up_outlined,
                  //           color: AppColors.white),
                  //       collapsedIcon: Icon(Icons.keyboard_arrow_down_outlined,
                  //           color: AppColors.white),
                  //       contentBorder: Border.all(
                  //         color: AppColors.primary,
                  //       ),
                  //       expandedTitleBackgroundColor: AppColors.primary,
                  //       contentBorderRadius: BorderRadius.vertical(
                  //         bottom: Radius.circular(12),
                  //       ),
                  //       titleBorderRadius: BorderRadius.vertical(
                  //         top: Radius.circular(12),
                  //       ),
                  //       title: "Transfer Details",
                  //       textStyle: TextStyle(color: AppColors.white),
                  //       collapsedTitleBackgroundColor: AppColors.mutedColor,
                  //       //     content: "Transfer Details",
                  //       contentChild: Column(
                  //         children: [
                  //           SizedBox(
                  //             height: 10,
                  //           ),
                  //           CommonWidgets.textField(
                  //             context,
                  //             suffixicon: false,
                  //             readonly: true,
                  //             keyboardtype: TextInputType.datetime,
                  //             controller: TextEditingController(
                  //                 text: DateFormatter.dateFormat.format(
                  //                     recieveController.selectedDate.value)),
                  //             label: 'Date',
                  //             ontap: () async {
                  //               DateTime newDate =
                  //                   await CommonWidgets.getCalender(
                  //                           context,
                  //                           recieveController
                  //                               .selectedDate.value) ??
                  //                       DateTime.now();
                  //               recieveController.selectDates(newDate);
                  //             },
                  //             onchanged: (value) {},
                  //           ),
                  //           SizedBox(
                  //             height: 20,
                  //           ),
                  //           CommonWidgets.textField(
                  //             context,
                  //             suffixicon: true,
                  //             readonly: true,
                  //             keyboardtype: TextInputType.datetime,
                  //             controller: TextEditingController(
                  //                 text:
                  //                     '${recieveController.selectedVendor.value.code} - ${recieveController.selectedVendor.value.name}'),
                  //             label: 'Vendor',
                  //             ontap: () {
                  //               CommonWidgets.commonDialog(
                  //                   context,
                  //                   'Vendors',
                  //                   ListView.separated(
                  //                       shrinkWrap: true,
                  //                       itemBuilder: (context, index) {
                  //                         VendorModel item =
                  //                             recieveController.vendorList[index];
                  //                         return CommonWidgets.commonListTile(
                  //                             context: context,
                  //                             code: item.code ?? '',
                  //                             name: item.name ?? '',
                  //                             onPressed: () {
                  //                               recieveController
                  //                                   .selectVendor(index);
                  //                               Navigator.pop(context);
                  //                             });
                  //                       },
                  //                       separatorBuilder: (context, index) =>
                  //                           SizedBox(
                  //                             height: 8,
                  //                           ),
                  //                       itemCount:
                  //                           recieveController.vendorList.length));
                  //             },
                  //           ),
                  //           SizedBox(
                  //             height: 20,
                  //           ),
                  //           CommonWidgets.textField(context,
                  //               suffixicon: false,
                  //               readonly: false,
                  //               keyboardtype: TextInputType.text,
                  //               label: 'Note',
                  //               controller: recieveController.note.value,
                  //               maxLength: null,
                  //               maxLines: null)
                  //         ],
                  //       ),
                  //     ))),
                  SizedBox(
                    height: 30,
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
                    return recieveController.recieveItemList.isEmpty
                        ? const Center(
                            child: Text(
                              "No Data. Click add button to add details",
                              style: TextStyle(color: AppColors.mutedColor),
                            ),
                          )
                        : Expanded(
                            child: GetBuilder<RecieveController>(
                              builder: (_) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: _.recieveItemList.length,
                                  itemBuilder: (context, index) {
                                    var item = _.recieveItemList[index];
                                    ProductListModel items =
                                        _.filterProductList[index];
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
                                                    foregroundColor:
                                                        Colors.green,
                                                    icon: Icons
                                                        .mode_edit_outlined,
                                                    onPressed: (_) {
                                                      log("${item.unitList!.length} unitlength");
                                                      // recieveController. productUnitList.value = item.unitList ?? [];
                                                      recieveController
                                                          .getDataToUpdate(
                                                              item,
                                                              item.unitList ??
                                                                  []);
                                                      CommonWidgets.commonDialog(
                                                          context,
                                                          "${item.product?.description ?? ''}",
                                                          AddUpdateItemRecieve(
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
                                                                    onTap:
                                                                        () async {
                                                                      log("${item.product.isTrackLot} isTrackLot");
                                                                      item.product.isTrackLot ==
                                                                              1
                                                                          ? await showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  insetPadding: EdgeInsets.all(10),
                                                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                                                                                  title: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Row(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Flexible(
                                                                                            child: Text(
                                                                                              "Lot Selection",
                                                                                              style: TextStyle(color: AppColors.mutedColor, fontWeight: FontWeight.w500, fontSize: 15),
                                                                                            ),
                                                                                          ),
                                                                                          InkWell(
                                                                                            onTap: () {
                                                                                              // recieveController
                                                                                              //     .lotlistItems
                                                                                              //     .clear();
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: CircleAvatar(
                                                                                              radius: 12,
                                                                                              backgroundColor: AppColors.mutedColor,
                                                                                              child: Icon(
                                                                                                Icons.close,
                                                                                                color: AppColors.white,
                                                                                                size: 15,
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      Divider(
                                                                                        color: AppColors.lightGrey,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  content: _buildLotListPopContent(context, code: item.product?.productId, name: item.product?.description, product: item.product),
                                                                                );
                                                                              },
                                                                            )
                                                                          : recieveController
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
                                                      recieveController
                                                          .deleteItem(index),
                                                ),
                                              ],
                                            ),
                                            child: GestureDetector(
                                                onDoubleTap: () {
                                                  // itemDetailsController
                                                  //     .updateValuesFromInventory(
                                                  //         recieveController
                                                  //             .recieveItemList[index]
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
              key: const Key('recieve'),
              onTap: () {
                CommonWidgets.commonDialog(
                    context, "Scan", RecieveItemPicker());
              },
              icon: const Icon(
                Icons.qr_code_rounded,
                color: Colors.white,
              ),
            ),
          ],
        );
      }),
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
                        'Do you want to close GRN ? This actioln will clear current data'),
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
                  Get.delete<RecieveController>();
                  // Get.back();
                  Navigator.pop(context);
                }
              }, type: ButtonTypes.Secondary, text: 'Cancel', isLoading: false),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Obx(() => CommonWidgets.elevatedButton(context, onTap: () {
                    recieveController.createGoodsRecieveNotes();
                  },
                      type: ButtonTypes.Primary,
                      text: 'Save',
                      isLoading: recieveController.isSaving.value)),
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

  Column _buildOpenListHeader(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => CommonWidgets.commonDateFilter(
                context,
                recieveController.dateIndex.value,
                recieveController.isToDate.value,
                recieveController.isFromDate.value,
                recieveController.fromDate.value,
                recieveController.toDate.value, (value) {
              selectedSysdocValue = value;
              recieveController.selectDateRange(selectedSysdocValue.value,
                  DateRangeSelector.dateRange.indexOf(selectedSysdocValue));
            },
                () => recieveController.selectDate(
                    context, recieveController.isFromDate.value))),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              recieveController.getRecieveReportOpenList();
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

  TextField _buildDateTextFeild(BuildContext context,
      {required String label,
      required Function() onTap,
      required bool enabled,
      required bool isDate,
      required TextEditingController controller}) {
    return TextField(
      controller: controller,
      readOnly: true,
      enabled: enabled,
      onTap: onTap,
      style: TextStyle(
        fontSize: 14,
        color: enabled ? Theme.of(context).primaryColor : mutedColor,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w400,
        ),
        isCollapsed: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        suffix: Icon(
          isDate ? Icons.calendar_month : Icons.location_pin,
          size: 15,
          color: enabled ? Theme.of(context).primaryColor : mutedColor,
        ),
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
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => recieveController.isOpenListLoading.value
                    ? CommonWidgets.popShimmer()
                    : recieveController.recieveOpenList.isEmpty
                        ? Center(
                            child: Text('No Data Found'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: recieveController.recieveOpenList.length,
                            itemBuilder: (context, index) {
                              var item =
                                  recieveController.recieveOpenList[index];
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
                                    await recieveController.getGRNById(
                                        item: item);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              '${item.docId} - ${item.docNumber}',
                                              minFontSize: 12,
                                              maxFontSize: 18,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        _buildTileRow(
                                            title: "Vendor",
                                            content:
                                                "${item.vendorCode ?? ""} - ${item.vendorName ?? ""}"),
                                        SizedBox(height: 5),
                                        _buildTileRow(
                                            title: "Buyer",
                                            content: item.buyer ?? ""),
                                        SizedBox(height: 5),
                                        _buildTileRow(
                                            title: "Quote Date",
                                            content: item.quoteDate != null
                                                ? DateFormatter.dateFormat
                                                    .format(item.quoteDate!)
                                                : ''),
                                        SizedBox(height: 5),
                                        _buildTileRow(
                                            title: "Reference",
                                            content: item.ref1 ?? ""),
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

  Row _buildTileRow({required String title, required String content}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          '$title : ',
          minFontSize: 8,
          maxFontSize: 12,
          style: const TextStyle(
            color: mutedColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          child: AutoSizeText(
            content,
            minFontSize: 10,
            maxFontSize: 12,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Column addLotPopUp(
    BuildContext context, {
    required String code,
    required String name,
    required bool isUpdate,
    ProductListModel? product,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              code,
              style: TextStyle(
                  color: AppColors.mutedColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: TextStyle(
                  color: AppColors.mutedColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Obx(() => CommonWidgets.textField(
              context,
              suffixicon: false,
              readonly: true,
              keyboardtype: TextInputType.datetime,
              controller: TextEditingController(
                  text:
                      '${recieveController.selectedLocation.value.code} - ${recieveController.selectedLocation.value.name}'),
              label: 'Location',
            )),
        SizedBox(
          height: 15,
        ),
        Obx(() => CommonWidgets.textField(context,
            suffixicon: false,
            readonly: false,
            label: "LotNumber",
            controller: recieveController.lotnumberController.value,
            keyboardtype: TextInputType.number)),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: Obx(() => CommonWidgets.textField(
                    context,
                    suffixicon: true,
                    readonly: true,
                    keyboardtype: TextInputType.datetime,
                    controller: TextEditingController(
                        text: DateFormatter.dateFormat
                            .format(recieveController.selectedProDate.value)),
                    label: 'ProDate',
                    icon: Icons.calendar_month,
                    ontap: () async {
                      DateTime newDate = await CommonWidgets.getCalender(
                              context,
                              recieveController.selectedProDate.value) ??
                          DateTime.now();
                      recieveController.selectProDates(newDate);
                    },
                    onchanged: (value) {},
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Obx(() => CommonWidgets.textField(
                    context,
                    suffixicon: true,
                    readonly: true,
                    keyboardtype: TextInputType.datetime,
                    controller: TextEditingController(
                        text: DateFormatter.dateFormat
                            .format(recieveController.selectedExpDate.value)),
                    label: 'ExpDate',
                    icon: Icons.calendar_month,
                    ontap: () async {
                      DateTime newDate = await CommonWidgets.getCalender(
                              context,
                              recieveController.selectedExpDate.value) ??
                          DateTime.now();
                      recieveController.selectExpDates(newDate);
                    },
                    onchanged: (value) {},
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Obx(() => CommonWidgets.textField(context,
            suffixicon: false,
            readonly: false,
            label: "Quantity",
            controller: recieveController.lotqty.value,
            keyboardtype: TextInputType.number)),
        const SizedBox(
          height: 20,
        ),
        Visibility(
          visible: isUpdate == false,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CommonWidgets.elevatedButton(context, onTap: () {
              if (recieveController.lotqty.value.text.isNotEmpty &&
                  recieveController.lotnumberController.value.text.isNotEmpty) {
                recieveController.addLotItem(code);
                recieveController.clearlotData();
                Navigator.pop(context);
              } else {
                SnackbarServices.errorSnackbar("Please add lot details");
              }
            }, type: ButtonTypes.Primary, text: 'Add'),
          ),
        ),
      ],
    );
  }

  SizedBox _buildLotListPopContent(
    BuildContext context, {
    required String code,
    required String name,
    ProductListModel? product,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    code,
                    style: TextStyle(
                        color: AppColors.mutedColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        color: AppColors.mutedColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => CommonWidgets.textField(
                    context,
                    suffixicon: true,
                    readonly: true,
                    keyboardtype: TextInputType.datetime,
                    controller: TextEditingController(
                        text:
                            '${recieveController.selectedLocation.value.code} - ${recieveController.selectedLocation.value.name}'),
                    label: 'Location',
                  )),
              SizedBox(
                height: 15,
              ),
              Obx(() => CommonWidgets.textField(context,
                  suffixicon: false,
                  readonly: true,
                  label: "Quantity",
                  controller: TextEditingController(
                      text: recieveController.quantity.value.toString()),
                  keyboardtype: TextInputType.number)),
              SizedBox(
                height: 14,
              ),
              _buildHeaderLot(context),

              // inventoryItemLocalListController.getInventory();

              Expanded(
                child: GetBuilder<RecieveController>(
                  builder: (_) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _.lotlistItemsForGrid.length,
                      itemBuilder: (context, index) {
                        var item = _.lotlistItemsForGrid[index];
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: Slidable(
                                key: const Key('inventory_items'),
                                startActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.green,
                                        icon: Icons.mode_edit_outlined,
                                        onPressed: (_) {
                                          recieveController.getLotDataToUpdate(
                                              item, index);
                                          CommonWidgets.commonDialog(
                                              context,
                                              "",
                                              addLotPopUp(context,
                                                  code: code,
                                                  name: name,
                                                  isUpdate: true),
                                              actions: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CommonWidgets
                                                          .elevatedButton(
                                                        context,
                                                        onTap: () {
                                                          recieveController
                                                              .updateLotItem(
                                                            index,
                                                          );
                                                          recieveController
                                                              .clearlotData();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        type:
                                                            ButtonTypes.Primary,
                                                        text: "Update",
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
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.red,
                                      icon: Icons.delete,
                                      onPressed: (_) => recieveController
                                          .deleteLotItem(index),
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                    onDoubleTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: _buildLotRows(context,
                                          lotnumber: "${item.lotNumber ?? ""}",
                                          prodate: item.proDate != null
                                              ? "${DateFormatter.dateFormat.format(item.proDate!)}"
                                              : "",
                                          expdate: item.expDate != null
                                              ? "${DateFormatter.dateFormat.format(item.expDate!)}"
                                              : "",
                                          qty: "${item.quantity ?? 0.0}",
                                          isHeader: false),
                                    ))));
                      },
                    );
                  },
                ),
              ),
              // CommonWidgets.elevatedButton(context, onTap: () {
              //                 recieveController.lotlistItems.clear();
              //                 Navigator.pop(context);
              //               }, type: ButtonTypes.Secondary, text: 'Clear'),
              // const SizedBox(
              //   width: 10,
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CommonWidgets.elevatedButton(context, onTap: () {
                  if (recieveController.isQuantityMatchedForGrid()) {
                    recieveController.addItem(AddItemRecieveModel(
                      product: product,
                      unitList: recieveController.productUnitList,
                      updatedLocation: recieveController.selectedLocation.value,
                      updatedQuantity: double.parse(
                          recieveController.quantity.value.toString()),
                      updatedUnit: recieveController.selectedUnit.value,
                      remarks: recieveController.remarksController.value.text,
                      lotList: recieveController.lotlistItemsForGrid.toList(),
                    ));

                    Navigator.pop(context);
                    // recieveController.lotlistItems.clear();
                  } else {
                    SnackbarServices.errorSnackbar(
                        'Lot allocation is not proper');
                  }
                }, type: ButtonTypes.Primary, text: 'Save'),
              ),
            ],
          ),
          Positioned(
            bottom: 50.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                CommonWidgets.commonDialog(
                    context,
                    "",
                    addLotPopUp(context,
                        code: code,
                        name: name,
                        product: product,
                        isUpdate: false));
              },
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Row _buildLotRows(BuildContext context,
      {required String lotnumber,
      required String prodate,
      required String expdate,
      required String qty,
      required bool isHeader}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            lotnumber,
            style: TextStyle(
              fontSize: 14,
              color: isHeader
                  ? Theme.of(context).primaryColor
                  : AppColors.mutedColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            prodate,
            style: TextStyle(
              fontSize: 14,
              color: isHeader
                  ? Theme.of(context).primaryColor
                  : AppColors.mutedColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            expdate,
            style: TextStyle(
              fontSize: 14,
              color: isHeader
                  ? Theme.of(context).primaryColor
                  : AppColors.mutedColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            qty,
            style: TextStyle(
              fontSize: 14,
              color: isHeader
                  ? Theme.of(context).primaryColor
                  : AppColors.mutedColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Container _buildHeaderLot(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: _buildLotRows(context,
            lotnumber: 'LotNumber',
            prodate: 'ProDate',
            expdate: "ExpDate",
            qty: "Quantity",
            isHeader: true),
      ),
    );
  }
}
