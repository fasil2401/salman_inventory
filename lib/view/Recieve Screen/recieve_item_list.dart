import 'dart:developer';

import 'package:axolon_inventory_manager/controller/App%20Controls/recieve_controller.dart';
import 'package:axolon_inventory_manager/model/Recieve%20Item%20Model/add_recieve_item_model.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Components/dragging_button.dart';
import 'package:axolon_inventory_manager/view/Recieve%20Screen/add_item_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class RecieveItemListScreen extends StatelessWidget {
  RecieveItemListScreen({super.key});
  final recieveController = Get.put(RecieveController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: Column(
        children: [
          _buildHeader(context),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonWidgets.textField(
              context,
              suffixicon: true,
              readonly: false,
              keyboardtype: TextInputType.text,
              label: 'Search',
              icon: Icons.search,
              onchanged: (value) {
                recieveController.searchProduct(value);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: GetBuilder<RecieveController>(
                initState: (_) {},
                builder: (_) {
                  return _.isLoadingProducts.value
                      ? Center(
                          child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ))
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            ProductListModel item = _.filterProductList[index];
                            return InkWell(
                              onTap: () async {
                                await _.selectSearchItem(item);
                                CommonWidgets.commonDialog(
                                    context,
                                    "${item.description ?? ''}",
                                    AddUpdateItemRecieve(),
                                    actions: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CommonWidgets.elevatedButton(
                                              context,
                                              onTap: () async {
                                                log("${item.isTrackLot} isTrackLot");
                                                log("${recieveController.productUnitList} lenggthhhh");

                                                item.isTrackLot == 1
                                                    ? await showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            insetPadding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                            title: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        "Lot Selection",
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.mutedColor,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: 15),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        recieveController
                                                                            .lotlistItems
                                                                            .clear();
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          CircleAvatar(
                                                                        radius:
                                                                            12,
                                                                        backgroundColor:
                                                                            AppColors.mutedColor,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              AppColors.white,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Divider(
                                                                  color: AppColors
                                                                      .lightGrey,
                                                                ),
                                                              ],
                                                            ),
                                                            content: _buildLotListPopContent(
                                                                context,
                                                                code: item
                                                                    .productId
                                                                    .toString(),
                                                                name: item
                                                                    .description
                                                                    .toString(),
                                                                product: item),
                                                          );
                                                        },
                                                      )
                                                    : recieveController.addItem(AddItemRecieveModel(
                                                        product: item,
                                                        unitList:
                                                            recieveController
                                                                .productUnitList,
                                                        updatedLocation:
                                                            recieveController
                                                                .selectedLocation
                                                                .value,
                                                        updatedQuantity:
                                                            double.parse(
                                                                recieveController
                                                                    .quantity
                                                                    .value
                                                                    .toString()),
                                                        updatedUnit:
                                                            recieveController
                                                                .selectedUnit
                                                                .value,
                                                        remarks: recieveController
                                                            .remarksController
                                                            .value
                                                            .text));
                                                Navigator.pop(context);
                                              },
                                              type: ButtonTypes.Primary,
                                              text: "Add",
                                            ),
                                          ),
                                        ],
                                      )
                                    ]);
                              },
                              child: _buildRows(
                                context,
                                code: '${item.productId}',
                                name: '${item.description}',
                                isHeader: false,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: height * 0.03,
                          ),
                          itemCount: _.filterProductList.length,
                        );
                },
              ),
            ),
          )
        ],
      ),
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
                      itemCount: _.lotlistItems.length,
                      itemBuilder: (context, index) {
                        var item = _.lotlistItems[index];
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
                  if (recieveController.isQuantityMatched()) {

                    recieveController.addItem(AddItemRecieveModel(
                      product: product,
                      unitList: recieveController.productUnitList,
                      updatedLocation: recieveController.selectedLocation.value,
                      updatedQuantity: double.parse(
                          recieveController.quantity.value.toString()),
                      updatedUnit: recieveController.selectedUnit.value,
                      remarks: recieveController.remarksController.value.text,
                      lotList: recieveController.lotlistItems.toList(),
                    ));

                    Navigator.pop(context);
                    recieveController.lotlistItems.clear();

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

  Container _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: _buildRows(context, code: 'Code', name: 'Name', isHeader: true),
      ),
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

  Row _buildRows(BuildContext context,
      {required String code, required String name, required bool isHeader}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            code,
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
          flex: 7,
          child: Text(
            name,
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
}
