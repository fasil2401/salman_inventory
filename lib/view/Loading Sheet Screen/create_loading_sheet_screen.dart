import 'dart:developer';
import 'package:axolon_inventory_manager/controller/App%20Controls/home_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/loading_sheet_controller.dart';
import 'package:axolon_inventory_manager/model/Loading%20Sheet%20Model/item_model.dart';
import 'package:axolon_inventory_manager/model/get_user_location_model.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/product_common_combo_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/services/extensions.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:getwidget/getwidget.dart';

import 'Components/quantity_adding_sheet.dart';
import 'package:get/get.dart';

import 'loading_sheet_itemname_code_screen.dart';

class CreateLoadingSheetScreen extends StatelessWidget {
  CreateLoadingSheetScreen({super.key});
  final LoadingSheetsController controller = Get.put(LoadingSheetsController());
  final homeController = Get.put(HomeController());
  FocusNode focus = FocusNode();

  void _handleKeyboardEvent(RawKeyEvent event) {
    String scannedData = '';
    if (event.runtimeType == RawKeyUpEvent) {
      // Process scanner input when a key is released
      scannedData = event.data.logicalKey.keyLabel;
      controller.scanItemCode(scannedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => controller.saveLoadingSheet(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Create Loading Sheet',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Obx(() => sysDocIdAndSheetNo(
                    //         context: context,
                    //         firstHead: "DocId : ",
                    //         secondHead: "${controller.sysDocId.value.code}")),
                    //     Obx(() => sysDocIdAndSheetNo(
                    //         context: context,
                    //         firstHead: 'Sheet No : ',
                    //         secondHead: "  ${controller.voucherNumber.value}")),
                    //   ],
                    // ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => CommonWidgets.textField(
                                context,
                                suffixicon: true,
                                readonly: true,
                                keyboardtype: TextInputType.text,
                                ontap: controller.dataList.isEmpty
                                    ? () {
                                        CommonWidgets.commonDialog(
                                            context,
                                            'System Doccuments',
                                            ListView.separated(
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  SysDocModel item = controller
                                                      .sysDocList[index];
                                                  return CommonWidgets
                                                      .commonListTile(
                                                          context: context,
                                                          code: item.code ?? '',
                                                          name: item.name ?? '',
                                                          onPressed: () {
                                                            controller
                                                                .selectSyDoc(
                                                                    index);
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                },
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                itemCount: controller
                                                    .sysDocList.length));
                                      }
                                    : () {},
                                controller: TextEditingController(
                                    text:
                                        '${controller.sysDocId.value.code} - ${controller.sysDocId.value.name}'),
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
                              controller.voucherNumber.value,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => CommonWidgets.textField(context,
                          suffixicon: true,
                          icon: Icons.arrow_drop_down_circle_outlined,
                          readonly: true,
                          keyboardtype: TextInputType.none,
                          controller: TextEditingController(
                            text:
                                "Document Type : ${controller.selectedDocument.value.name}",
                          ), ontap: () async {
                        controller.filterDocumentTypeList.value =
                            controller.documentTypeList;
                        controller.filterDocumentTypeList
                          ..sort((a, b) => a.name.compareTo(b.name));
                        await CommonWidgets.commonDialog(
                            context,
                            "Document Type",
                            documentTypeContent(
                              context: context,
                            ));
                      }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Visibility(
                        visible: !(controller.selectedDocument.value.type == 3),
                        child: CommonWidgets.textField(context,
                            suffixicon: true,
                            icon: Icons.arrow_drop_down_circle_outlined,
                            readonly: true,
                            keyboardtype: TextInputType.none,
                            controller: TextEditingController(
                              text: controller.selectedDocument.value.type == 1
                                  ? "Customer Name : ${controller.selectedCustomer.value.name ?? ''}"
                                  : "Party Name : ${controller.selectedParty.value.name ?? ''}",
                            ), ontap: () async {
                          if (controller.selectedDocument.value.type == 1) {
                            controller.filterPartyList.value =
                                controller.customerList;
                          } else {
                            controller.filterPartyList.value =
                                controller.partyList;
                          }
                          await CommonWidgets.commonDialog(context,
                              "Party Name", partyNameContent(context: context));
                        }),
                      ),
                    ),
                    Obx(() => SizedBox(
                          height: !(controller.selectedDocument.value.type == 3)
                              ? 10
                              : 0,
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: Obx(() => CommonWidgets.textField(context,
                                    suffixicon: true,
                                    icon: Icons.edit,
                                    readonly: true,
                                    keyboardtype: TextInputType.none,
                                    controller: TextEditingController(
                                      text:
                                          "Start Time : ${controller.selectedStartTime.value.format(context)}",
                                    ), ontap: () async {
                                  await controller.selectStartTime(context);
                                  if (controller.dataList.isNotEmpty) {
                                    controller.saveLoadingSheet();
                                  }
                                }))),
                        SizedBox(width: 10),
                        Expanded(
                            child:
                                // GetX<LoadingSheetsController>(
                                //     builder: (controller) =>
                                Obx(() => CommonWidgets.textField(context,
                                        suffixicon: true,
                                        icon: Icons.edit,
                                        readonly: true,
                                        keyboardtype: TextInputType.none,
                                        controller: TextEditingController(
                                          text:
                                              "End Time : ${controller.selectedEndTime.value.format(context)}",
                                        ), ontap: () async {
                                      await controller.selectEndTime(context);
                                      if (controller.dataList.isNotEmpty) {
                                        controller.saveLoadingSheet();
                                      }
                                    })))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Obx(
                      () => InkWell(
                        onTap: () {
                          controller.openAccordian();
                        },
                        child: GFAccordion(
                            margin: EdgeInsets.all(0),
                            showAccordion: controller.isOpenAccordian.value,
                            expandedIcon: Icon(Icons.keyboard_arrow_up_outlined,
                                color: AppColors.white),
                            collapsedIcon: Icon(
                                Icons.keyboard_arrow_down_outlined,
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
                            title: "More Details",
                            textStyle: TextStyle(color: AppColors.white),
                            collapsedTitleBackgroundColor: AppColors.mutedColor,
                            //     content: "Transfer Details",
                            contentChild: Column(children: [
                              SizedBox(
                                height: 10,
                              ),
                              Obx(() => CommonWidgets.textField(
                                    context,
                                    suffixicon: true,
                                    icon: Icons.edit,
                                    readonly: true,
                                    keyboardtype: TextInputType.none,
                                    label: "Date",
                                    controller: TextEditingController(
                                      text:
                                          '${controller.selectedDate.value.toLocal()}'
                                              .split(' ')[0],
                                    ),
                                    //     ontap: () async {
                                    //   await controller.selectDate(context);
                                    //   if (controller.dataList.isNotEmpty) {
                                    //     controller.saveLoadingSheet();
                                    //   }
                                    // }
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    Expanded(
                                      child: CommonWidgets.textField(
                                        context,
                                        suffixicon: true,
                                        icon: Icons
                                            .arrow_drop_down_circle_outlined,
                                        readonly: true,
                                        keyboardtype: TextInputType.none,
                                        label: "From Location:",
                                        controller: TextEditingController(
                                            text: controller
                                                        .selectedFromLocation
                                                        .value
                                                        .code !=
                                                    null
                                                ? '${controller.selectedFromLocation.value.code} - ${controller.selectedFromLocation.value.name}'
                                                : ''),
                                        ontap: () async {
                                          await CommonWidgets.commonDialog(
                                              context,
                                              'From Locations',
                                              ListView.separated(
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    UserLocationModel item =
                                                        controller
                                                                .userLocationList[
                                                            index];
                                                    return CommonWidgets
                                                        .commonListTile(
                                                            context: context,
                                                            code:
                                                                item.code ?? '',
                                                            name:
                                                                item.name ?? '',
                                                            onPressed:
                                                                () async {
                                                              await controller
                                                                  .selectFromLocation(
                                                                      index);
                                                              if (controller
                                                                  .dataList
                                                                  .isNotEmpty) {
                                                                controller
                                                                    .saveLoadingSheet();
                                                              }
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                  },
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                  itemCount: controller
                                                      .userLocationList
                                                      .length));
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: !(controller.selectedDocument.value
                                                  .type ==
                                              3)
                                          ? 0
                                          : 10,
                                    ),
                                    !(controller.selectedDocument.value.type ==
                                            3)
                                        ? SizedBox()
                                        : Expanded(
                                            child: CommonWidgets.textField(
                                              context,
                                              suffixicon: true,
                                              icon: Icons
                                                  .arrow_drop_down_circle_outlined,
                                              readonly: true,
                                              keyboardtype: TextInputType.none,
                                              label: "To Location:",
                                              controller: TextEditingController(
                                                  text: controller
                                                              .selectedToLocation
                                                              .value
                                                              .code !=
                                                          null
                                                      ? '${controller.selectedToLocation.value.code} - ${controller.selectedToLocation.value.name}'
                                                      : ''),
                                              ontap: () {
                                                CommonWidgets.commonDialog(
                                                    context,
                                                    'To Locations',
                                                    ListView.separated(
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          LocationModel item =
                                                              controller
                                                                      .locationList[
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
                                                                      () async {
                                                                    await controller
                                                                        .selectToLocation(
                                                                            index);
                                                                    if (controller
                                                                        .dataList
                                                                        .isNotEmpty) {
                                                                      controller
                                                                          .saveLoadingSheet();
                                                                    }
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                        },
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                        itemCount: controller
                                                            .locationList
                                                            .length));
                                              },
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CommonWidgets.textField(context,
                                  suffixicon: false,
                                  readonly: false,
                                  keyboardtype: TextInputType.streetAddress,
                                  label: "Address",
                                  maxLines: null,
                                  controller:
                                      controller.addressController.value),
                              SizedBox(
                                height: 10,
                              ),
                              CommonWidgets.textField(context,
                                  suffixicon: false,
                                  readonly: false,
                                  keyboardtype: TextInputType.number,
                                  label: "Phone No.",
                                  controller:
                                      controller.phoneNumberController.value),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: CommonWidgets.textField(context,
                                          suffixicon: true,
                                          readonly: true,
                                          keyboardtype: TextInputType.text,
                                          ontap: () {
                                    filtingList(
                                        context: context,
                                        label: "Sales Person",
                                        list: controller.salesPersonList,
                                        textController:
                                            TextEditingController());
                                  },
                                          label: "Sales Person",
                                          controller: TextEditingController(
                                              text:
                                                  "${controller.selectedSalesPerson.value.name ?? ''}"))),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: CommonWidgets.textField(context,
                                          suffixicon: true,
                                          readonly: true,
                                          keyboardtype: TextInputType.text,
                                          ontap: () {
                                    filtingList(
                                      context: context,
                                      label: "Vehicle No",
                                      list: controller.vehicleNoList,
                                      textController: TextEditingController(),
                                    );
                                  },
                                          label: "Vehicle No.",
                                          controller: TextEditingController(
                                              text:
                                                  "${controller.selectedVehicleNo.value.name ?? ''}")))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: CommonWidgets.textField(context,
                                          suffixicon: true,
                                          readonly: true, ontap: () {
                                    filtingList(
                                        context: context,
                                        label: "Driver Name",
                                        list: controller.driverNameList,
                                        textController:
                                            TextEditingController());
                                  },
                                          keyboardtype: TextInputType.text,
                                          label: "Driver Name",
                                          controller: TextEditingController(
                                              text:
                                                  "${controller.selectedDriverName.value.name ?? ''}"))),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: CommonWidgets.textField(
                                    context,
                                    suffixicon: false,
                                    readonly: false,
                                    keyboardtype: TextInputType.text,
                                    controller:
                                        controller.containerNoController.value,
                                    label: "Container No.",
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonWidgets.textField(context,
                                        suffixicon: false,
                                        readonly: false,
                                        keyboardtype: TextInputType.text,
                                        maxLines: null,
                                        label: "Ref1",
                                        controller:
                                            controller.ref1Controller.value),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: CommonWidgets.textField(context,
                                        suffixicon: false,
                                        readonly: false,
                                        keyboardtype: TextInputType.text,
                                        maxLines: null,
                                        controller:
                                            controller.ref2Controller.value,
                                        label: "Ref2"),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CommonWidgets.textField(context,
                                  suffixicon: false,
                                  readonly: false,
                                  keyboardtype: TextInputType.text,
                                  maxLines: null,
                                  controller: controller.ref3Controller.value,
                                  label: "Ref3"),
                              SizedBox(
                                height: 10,
                              ),
                              CommonWidgets.textField(context,
                                  suffixicon: false,
                                  readonly: false,
                                  keyboardtype: TextInputType.text,
                                  label: "Remarks",
                                  maxLines: null,
                                  controller:
                                      controller.remarksController.value),
                            ])),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => _buildTileText(
                          text:
                              "${controller.dataList.map((element) => element.product?.category).toList().toSet().toList().join(', ')}",
                          title: 'Item Category : '),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => _buildTileText(
                          text:
                              "${controller.totalQuanity.value.toStringAsFixed(2)}",
                          title: "Total Quantity :  "),
                    )
                  ],
                ),
              ),
              //  ),
              //),
              // ),
              // ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 10.0,
                color: lightGrey,
              ),
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            controller.clearInputValue();
                            controller.getItemList(context);
                            focus.requestFocus();
                            CommonWidgets.commonDialog(
                              context,
                              "",
                              _buildPopupBody(context),
                            );
                          },
                          child: Container(
                            // height: MediaQuery.of(context).size.height / 16,
                            width: MediaQuery.of(context).size.width / 3.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff01579b)),
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.symmetric(vertical: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text(
                                  "Add Items",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    GetBuilder<LoadingSheetsController>(builder: (controller) {
                      return controller.isLoadingDataList.value
                          ? CommonWidgets.popShimmer()
                          : controller.dataList.isEmpty
                              ? Center(child: Text("No Data"))
                              : ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.dataList.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 8,
                                  ),
                                  itemBuilder: (context, index) {
                                    Data item = controller.dataList[index];
                                    return Slidable(
                                      startActionPane: ActionPane(
                                          motion: const DrawerMotion(),
                                          children: [
                                            SlidableAction(
                                                backgroundColor:
                                                    Colors.green[100]!,
                                                foregroundColor:
                                                    AppColors.success,
                                                icon: Icons.edit,
                                                onPressed: (val) {
                                                  controller
                                                          .descriptionController
                                                          .value
                                                          .text =
                                                      item.description ?? '';
                                                  CommonWidgets.commonDialog(
                                                      context,
                                                      "Remarks ",
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Obx(
                                                            () => CommonWidgets.textField(
                                                                icon: Icons
                                                                    .arrow_drop_down_circle_outlined,
                                                                context,
                                                                suffixicon:
                                                                    false,
                                                                readonly: false,
                                                                keyboardtype:
                                                                    TextInputType
                                                                        .text,
                                                                maxLines: 5,
                                                                controller:
                                                                    controller
                                                                        .descriptionController
                                                                        .value,
                                                                maxLength: 200),
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        CommonWidgets
                                                            .elevatedButton(
                                                                context,
                                                                isLoading:
                                                                    false,
                                                                onTap:
                                                                    () async {
                                                          await controller
                                                              .updateDescription(
                                                                  index);
                                                          if (controller
                                                              .dataList
                                                              .isNotEmpty) {
                                                            controller
                                                                .saveLoadingSheet();
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                                type: ButtonTypes
                                                                    .Primary,
                                                                text: 'Save')
                                                      ]);
                                                })
                                          ]),
                                      endActionPane: ActionPane(
                                        motion: const DrawerMotion(),
                                        children: [
                                          SlidableAction(
                                            backgroundColor: Colors.red[100]!,
                                            foregroundColor: Colors.red,
                                            icon: Icons.delete,
                                            onPressed: (val) {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          Text('Confirmation'),
                                                      content: Text(
                                                          "Do you want to delete?"),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            await controller
                                                                .deleteItem(
                                                                    index);
                                                            if (controller
                                                                .dataList
                                                                .isNotEmpty) {
                                                              controller
                                                                  .saveLoadingSheet();
                                                            } else if (controller
                                                                    .headerExist() ==
                                                                1) {
                                                              controller
                                                                  .syncLoadingSheet();
                                                            }
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Yes'),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          shadowColor: Colors.black,
                                          elevation: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${item.product?.productId} :',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                "${item.product?.description ?? ''}",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        mutedColor),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // IconButton(
                                                      //     onPressed: () {
                                                      //       showDialog(
                                                      //           context: context,
                                                      //           builder: (BuildContext
                                                      //               context) {
                                                      //             return AlertDialog(
                                                      //               title: Text(
                                                      //                   'Confirmation'),
                                                      //               content: Text(
                                                      //                   "Do you want to delete?"),
                                                      //               actions: [
                                                      //                 TextButton(
                                                      //                   onPressed:
                                                      //                       () {
                                                      //                     Navigator.pop(
                                                      //                         context);
                                                      //                   },
                                                      //                   child: Text(
                                                      //                       'Cancel'),
                                                      //                 ),
                                                      //                 TextButton(
                                                      //                   onPressed:
                                                      //                       () {
                                                      //                     controller
                                                      //                         .deleteItem(
                                                      //                             index);

                                                      //                     Navigator.of(
                                                      //                             context)
                                                      //                         .pop();
                                                      //                   },
                                                      //                   child: Text(
                                                      //                       'Yes'),
                                                      //                 ),
                                                      //               ],
                                                      //             );
                                                      //           });
                                                      //     },
                                                      //     icon: Icon(
                                                      //       Icons.delete_outlined,
                                                      //       color: Colors.red,
                                                      //     ))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: _buildTileText(
                                                            text:
                                                                item.description ??
                                                                    '',
                                                            title:
                                                                'Remarks : '),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: _buildTileText(
                                                            text: item.product
                                                                    ?.brand ??
                                                                '',
                                                            title: 'Brand : '),
                                                      ),
                                                      Expanded(
                                                        child: _buildTileText(
                                                            text: item.product
                                                                    ?.origin ??
                                                                '',
                                                            title: 'Origin : '),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: _buildTileText(
                                                            text: item.qtyList!
                                                                .fold<double>(
                                                                    0.0,
                                                                    (previousValue,
                                                                            element) =>
                                                                        previousValue +
                                                                        element)
                                                                .toString(),
                                                            title:
                                                                'Quantity : '),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 60),
                                                        child: InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .quantity
                                                                  .value = item
                                                                      .qtyList
                                                                      ?.last
                                                                      .round() ??
                                                                  0;
                                                              print(
                                                                  "quantity${controller.quantityController.value.text}");
                                                              CommonWidgets
                                                                  .commonDialog(
                                                                context,
                                                                "Quantity",
                                                                QuantitySheet(
                                                                  onTapPercent:
                                                                      () {
                                                                    controller
                                                                        .addQuantity(
                                                                      index:
                                                                          index,
                                                                      qty: controller.quantityController.value.text.isEmpty &&
                                                                              controller.quantity.value >=
                                                                                  1
                                                                          ? controller
                                                                              .quantity
                                                                              .value
                                                                              .toDouble()
                                                                          : double.parse(controller
                                                                              .quantityController
                                                                              .value
                                                                              .text),
                                                                    );
                                                                  },
                                                                  onTapAmount:
                                                                      () {},
                                                                  onChangePercent:
                                                                      (value) {},
                                                                  onChangeAmount:
                                                                      (value) {},
                                                                  quantityController:
                                                                      controller
                                                                          .quantityController
                                                                          .value,
                                                                  previousQuantity: item
                                                                      .qtyList!
                                                                      .fold<double>(
                                                                          0.0,
                                                                          (previousValue, element) =>
                                                                              previousValue +
                                                                              element)
                                                                      .toString(),
                                                                  item: item,
                                                                ),
                                                              );
                                                            },
                                                            child: CircleAvatar(
                                                                minRadius: 14.0,
                                                                backgroundColor:
                                                                    Color(
                                                                        0xff01579b),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                ))),
                                                      )),
                                                      Expanded(
                                                        child:
                                                            SingleChildScrollView(
                                                                child: Text(
                                                          item.qtyList!
                                                              .join('+'),
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                          softWrap: true,
                                                          overflow:
                                                              TextOverflow.clip,
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    );
                                  },
                                );
                    }),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Expanded(
        //         child: CommonWidgets.elevatedButton(context, onTap: () {
        //           controller.cleardata();
        //         }, type: ButtonTypes.Secondary, text: 'Clear'),
        //       ),
        //       SizedBox(
        //         width: 15,
        //       ),
        //       Expanded(
        //         child: Obx(() => CommonWidgets.elevatedButton(context,
        //                 isLoading: controller.isSaving.value, onTap: () {
        //               //if (controller.isNewRecord.value) {
        //               // controller.save();
        //               // controller.saveLoadingSheetsInLocal();
        //               controller.cleardata();
        //               Navigator.pop(context);
        //               // controller.syncLoadingSheet();
        //               // } else {
        //               //   controller.cleardata();
        //               //   Navigator.pop(context);
        //               // }
        //             }, type: ButtonTypes.Primary, text: 'Save')),
        //       ),
        //     ],
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  partyNameContent({
    required BuildContext context,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonWidgets.textField(
          context,
          suffixicon: false,
          readonly: false,
          keyboardtype: TextInputType.text,
          onchanged: (value) {
            controller.filterPartyLists(value);
          },
          label: "Search",
        ),
        SizedBox(
          height: 10,
        ),
        Flexible(child: GetBuilder<LoadingSheetsController>(builder: (_) {
          return _.isPartListLoading.value
              ? CommonWidgets.popShimmer()
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                  shrinkWrap: true,
                  itemCount: controller.filterPartyList.length,
                  itemBuilder: (context, index) {
                    var item = controller.filterPartyList[index];
                    return InkWell(
                        onTap: () {
                          log("${controller.filterPartyList.runtimeType}");
                          if (controller.selectedDocument.value.type == 1) {
                            controller.selectedCustomer.value = item;
                          } else {
                            controller.selectedParty.value = item;
                          }
                          if (controller.dataList.isNotEmpty) {
                            controller.saveLoadingSheet();
                          }
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: AutoSizeText(
                            item.name ?? '',
                            minFontSize: 11,
                            maxFontSize: 13,
                            style: TextStyle(
                              color: mutedColor,
                            ),
                          ),
                        ));
                  },
                );
        })),
      ],
    );
  }

  documentTypeContent({required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonWidgets.textField(
          context,
          suffixicon: false,
          readonly: false,
          keyboardtype: TextInputType.text,
          label: "Search",
          onchanged: (element) => controller.filterdocList(element),
        ),
        SizedBox(
          height: 10,
        ),
        Flexible(child: GetBuilder<LoadingSheetsController>(builder: (_) {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
              thickness: 1,
            ),
            shrinkWrap: true,
            itemCount: controller.filterDocumentTypeList.length,
            itemBuilder: (context, index) {
              var item = controller.filterDocumentTypeList[index];
              return InkWell(
                  onTap: () {
                    controller.updateSelectedDocumentType(item);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: AutoSizeText(
                      item.name,
                      minFontSize: 11,
                      maxFontSize: 13,
                      style: TextStyle(
                        color: mutedColor,
                      ),
                    ),
                  ));
            },
          );
        })),
      ],
    );
  }

  Widget buildTextFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: mutedColor,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildPopupBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          buildTextFieldLabel('Class'),
          Obx(
            () => CommonWidgets.textField(context,
                suffixicon: true,
                readonly: true,
                keyboardtype: TextInputType.text,
                icon: Icons.arrow_drop_down_circle_outlined,
                controller: controller.classController.value,
                label: "", ontap: () {
              filtingList(
                  context: context,
                  label: "Item Class",
                  list: controller.classList,
                  textController: controller.classController.value);
            }),
          ),
          SizedBox(
            height: 13,
          ),
          buildTextFieldLabel('Category'),
          Obx(
            () => CommonWidgets.textField(context,
                suffixicon: true,
                readonly: true,
                keyboardtype: TextInputType.text,
                label: "",
                icon: Icons.arrow_drop_down_circle_outlined,
                controller: controller.categoryController.value, ontap: () {
              filtingList(
                  context: context,
                  label: "Category",
                  list: controller.categoryList,
                  textController: controller.categoryController.value);
            }),
          ),
          SizedBox(
            height: 13,
          ),
          buildTextFieldLabel('Brand'),
          Obx(() => CommonWidgets.textField(context,
                  controller: controller.brandController.value,
                  suffixicon: true,
                  icon: Icons.arrow_drop_down_circle_outlined,
                  label: '',
                  readonly: true, ontap: () async {
                filtingList(
                    context: context,
                    label: "Brand",
                    list: controller.brandList,
                    textController: controller.brandController.value);
              }, keyboardtype: TextInputType.name)),
          SizedBox(
            height: 13,
          ),
          buildTextFieldLabel('Origin'),
          Obx(() => CommonWidgets.textField(context,
                  controller: controller.originController.value,
                  suffixicon: true,
                  icon: Icons.arrow_drop_down_circle_outlined,
                  label: '',
                  readonly: true, ontap: () async {
                // _handleKeyboardEvent(RawKeyUpEvent(
                //     data: RawKeyEventDataAndroid(), character: '122333'));
                filtingList(
                    context: context,
                    label: "Origin",
                    list: controller.originList,
                    textController: controller.originController.value);
              }, keyboardtype: TextInputType.name)),
          SizedBox(
            height: 13,
          ),
          buildTextFieldLabel('Name'),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => CommonWidgets.textField(context,
                      suffixicon: false,
                      readonly: false,
                      focus: focus,
                      autofocus: true,
                      keyboardtype: TextInputType.text,
                      controller: controller.nameController.value,
                      icon: Icons.arrow_drop_down_circle_outlined,
                      label: "", ontap: () async {
                    //  controller.filterItemName();
                    // await CommonWidgets.commonDialog(context, "Name",
                    //     GetBuilder<LoadingSheetsController>(
                    //   builder: (_) {
                    //     return _.isLoadingProducts.value
                    //         ? CommonWidgets.popShimmer()
                    //         : ListView.separated(
                    //             shrinkWrap: true,
                    //             itemBuilder: (context, index) {
                    //               var itemname = _.nameList[index];
                    //               return InkWell(
                    //                 onTap: () {
                    //                   log("${index}");
                    //
                    //                   controller.nameController.value.text =
                    //                       "${itemname.productId} - ${itemname.description}";
                    //                   controller.updateSelectedProduct(itemname);
                    //
                    //                   Navigator.pop(context);
                    //                 },
                    //                 child: ListTile(
                    //                   // dense: true,
                    //                   minVerticalPadding: 0,
                    //                   contentPadding: EdgeInsets.symmetric(
                    //                       horizontal: 0.0, vertical: 0.0),
                    //                   visualDensity:
                    //                       VisualDensity(horizontal: 0, vertical: -4),
                    //                   title: Text(
                    //                       "${itemname.productId} - ${itemname.description}",
                    //                       style: TextStyle(fontFamily: 'Rubik')),
                    //                 ),
                    //               );
                    //             },
                    //             separatorBuilder: (context, index) => SizedBox(
                    //                 // height: height * 0.03,
                    //                 ),
                    //             itemCount: _.nameList.length,
                    //           );
                    //   },
                    // )
                    // );
                    //Get.to(() => LoadingsheetItemDetailItemListScreen());
                  }),
                ),
              ),
              InkWell(
                onTap: () {
                  controller.filterItemName();
                  Get.to(() => LoadingsheetItemDetailItemListScreen());
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 13,
          ),
          buildTextFieldLabel('Remarks'),
          Obx(
            () => CommonWidgets.textField(
              icon: Icons.arrow_drop_down_circle_outlined,
              context,
              suffixicon: false,
              readonly: false,
              keyboardtype: TextInputType.text,
              maxLines: 5,
              maxLength: 200,
              controller: controller.descriptionController.value,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 48,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                padding: EdgeInsets.all(5),
                child: Obx(() => AutoSizeText(
                      "Quantity(${controller.quantity.value})",
                      style: TextStyle(fontSize: 20, color: mutedColor),
                      minFontSize: 10,
                      maxFontSize: 13,
                    )),
              ),
              Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: MediaQuery.of(context).size.width / 12,
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(color: Colors.black12),
                      vertical: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  child: InkWell(
                      onTap: () {
                        controller.decrementQuantity();
                      },
                      child: Icon(
                        Icons.remove,
                        color: mutedColor,
                      ))),
              Obx(
                () {
                  controller.quantityController.value.selection =
                      TextSelection.fromPosition(TextPosition(
                          offset:
                              controller.quantityController.value.text.length));
                  return Flexible(
                    child: controller.isEditingQuantity.value
                        ? TextField(
                            autofocus: false,
                            controller: controller.quantityController.value,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*$')),
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              hintText: '',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              controller.setQuantity(value);
                            },
                            onTap: () {
                              controller.quantityController.value.selectAll();
                            },
                          )
                        : InkWell(
                            onTap: () {
                              controller.editQuantity();
                            },
                            child: Container(
                                height: 48,
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child:
                                    Text(controller.quantity.value.toString())),
                          ),
                  );
                },
              ),
              Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: MediaQuery.of(context).size.width / 12,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.zero),
                  child: InkWell(
                      onTap: () {
                        controller.incrementQuantity();
                      },
                      child: Icon(Icons.add))),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.width,
            child: CommonWidgets.elevatedButton(
              context,
              onTap: () async {
                print("quantity value::${controller.quantity.value}");
                if (controller.nameController.value.text.isEmpty) {
                  SnackbarServices.errorSnackbar("Please Enter Name");
                } else {
                  int counterValue = controller.quantity.value;
                  controller.addData(
                      controller.descriptionController.value.text,
                      counterValue);
                  controller.saveLoadingSheet();
                  controller.clearInputValue();
                  // controller.clearInputValue();

                  Navigator.pop(context);
                }
              },
              type: ButtonTypes.Primary,
              text: 'Add',
            ),
          )
        ],
      ),
    );
  }

  Row _buildTileTextAlert({
    required String title1,
    required String title2,
    required String title3,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 10,
        ),
        Text("$title1",
            textAlign: TextAlign.start,
            maxLines: 1,
            style: TextStyle(fontSize: 15, color: Colors.black)),
        SizedBox(
          width: 90,
        ),
        Expanded(
          child: Text(title2,
              textAlign: TextAlign.start,
              // maxLines: 2,
              style: TextStyle(fontSize: 15, color: Colors.black)),
        ),
        Expanded(
          child: Text(title3,
              textAlign: TextAlign.start,
              // maxLines: 2,
              style: TextStyle(fontSize: 15, color: Colors.black)),
        ),
      ],
    );
  }

  Row popupTitleview({required Function() onTap, required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: mutedColor,
            ),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: mutedColor,
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 15,
            ),
          ),
        )
      ],
    );
  }

  Row _buildTileText({required String title, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title",
            // textAlign: TextAlign.start,
            maxLines: 1,
            style: TextStyle(fontSize: 13, color: mutedColor)),
        Flexible(
          child: Text(text,
              //textAlign: TextAlign.start,
              // maxLines: 2,
              style: TextStyle(fontSize: 13, color: mutedColor)),
        ),
      ],
    );
  }

  sysDocIdAndSheetNo(
      {required BuildContext context,
      required String firstHead,
      required String secondHead}) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            firstHead,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor),
          ),
          Flexible(
            child: Text(secondHead,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18)),
          )
        ],
      ),
    );
  }

  filtingList(
      {required BuildContext context,
      required String label,
      required List list,
      required TextEditingController textController}) {
    controller.filterList.value = list;
    return CommonWidgets.commonDialog(
        context,
        label,
        Column(mainAxisSize: MainAxisSize.min, children: [
          CommonWidgets.textField(
            context,
            suffixicon: false,
            readonly: false,
            keyboardtype: TextInputType.text,
            label: "Search",
            onchanged: (element) => controller.commonFilter(element, list),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(child: GetBuilder<LoadingSheetsController>(builder: (_) {
            return _.isLoading.value
                ? CommonWidgets.popShimmer()
                : ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var item = controller.filterList[index];
                      return InkWell(
                        onTap: () {
                          if (label == "Sales Person") {
                            if (item.code == 'Clear') {
                              controller.selectedSalesPerson.value =
                                  ProductCommonComboModel();
                            } else {
                              controller.selectedSalesPerson.value =
                                  ProductCommonComboModel(
                                      code: item.code, name: item.name);
                            }
                            if (controller.dataList.isNotEmpty) {
                              controller.saveLoadingSheet();
                            }
                          } else if (label == "Vehicle No") {
                            if (item.code == 'Clear') {
                              controller.selectedVehicleNo.value =
                                  ProductCommonComboModel();
                            } else {
                              controller.selectedVehicleNo.value =
                                  ProductCommonComboModel(
                                      code: item.code, name: item.name);
                            }
                            if (controller.dataList.isNotEmpty) {
                              controller.saveLoadingSheet();
                            }
                          } else if (label == "Driver Name") {
                            if (item.code == 'Clear') {
                              controller.selectedDriverName.value =
                                  ProductCommonComboModel();
                            } else {
                              controller.selectedDriverName.value =
                                  ProductCommonComboModel(
                                      code: item.code, name: item.name);
                            }
                            if (controller.dataList.isNotEmpty) {
                              controller.saveLoadingSheet();
                            }
                          } else {
                            if (item.code == 'Clear') {
                              _.setToDefault(textController);
                            } else {
                              textController.text = "${item.name}";
                              _.setToDefault(controller.nameController.value);
                            }
                          }
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: AutoSizeText(
                            "${item.code ?? ''} ${item.code == 'Clear' ? '' : '-'} ${item.name ?? ''}",
                            minFontSize: 11,
                            maxFontSize: 13,
                            style: TextStyle(
                              color: mutedColor,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black12,
                      thickness: 1,
                    ),
                    itemCount: controller.filterList.length,
                  );
          }))
        ]));
  }
}
