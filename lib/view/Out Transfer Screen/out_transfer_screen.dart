import 'dart:developer';

import 'package:axolon_inventory_manager/controller/App%20Controls/out_transfer_controller.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/model/tansfer_type_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Components/dragging_button.dart';
import 'package:axolon_inventory_manager/view/Out%20Transfer%20Screen/add_item_popup.dart';
import 'package:axolon_inventory_manager/view/Out%20Transfer%20Screen/out_transfer_item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class OutTransferScreen extends StatelessWidget {
  OutTransferScreen({super.key});
  final outTransferController = Get.put(OutTransferController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Out Transfer"),
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
                                          SysDocModel item = outTransferController
                                              .sysDocList[index];
                                          return CommonWidgets.commonListTile(
                                              context: context,
                                              code: item.code ?? '',
                                              name: item.name ?? '',
                                              onPressed: () {
                                                outTransferController
                                                    .selectSyDoc(index);
                                                Navigator.pop(context);
                                              });
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              height: 8,
                                            ),
                                        itemCount: outTransferController
                                            .sysDocList.length));
                              },
                              controller: TextEditingController(
                                  text:
                                      '${outTransferController.selectedSysDoc.value.code} - ${outTransferController.selectedSysDoc.value.name}'),
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
                            outTransferController.voucherNumber.value,
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
                      outTransferController.openAccordian();
                    },
                    child: GFAccordion(
                      margin: EdgeInsets.all(0),
                      showAccordion: outTransferController.isOpenAccordian.value,
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
                                    outTransferController.selectedDate.value)),
                            label: 'Date',
                            ontap: () async {
                              DateTime newDate = await CommonWidgets.getCalender(
                                      context,
                                      outTransferController.selectedDate.value) ??
                                  DateTime.now();
                              outTransferController.selectDate(newDate);
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
                                    '${outTransferController.selectedLocation.value.code} - ${outTransferController.selectedLocation.value.name}'),
                            label: 'Location To',
                            ontap: () {
                              CommonWidgets.commonDialog(
                                  context,
                                  'Locations',
                                  ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        LocationModel item = outTransferController
                                            .locationList[index];
                                        return CommonWidgets.commonListTile(
                                            context: context,
                                            code: item.code ?? '',
                                            name: item.name ?? '',
                                            onPressed: () {
                                              outTransferController
                                                  .selectLocation(index);
                                              Navigator.pop(context);
                                            });
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 8,
                                          ),
                                      itemCount: outTransferController
                                          .locationList.length));
                            },
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
                                    '${outTransferController.selectedTransferType.value.code} - ${outTransferController.selectedTransferType.value.name}'),
                            label: 'Transfer Type',
                            ontap: () {
                              CommonWidgets.commonDialog(
                                  context,
                                  'Transfer Types',
                                  ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        TransferTypeModel item =
                                            outTransferController
                                                .transferTypeList[index];
                                        return CommonWidgets.commonListTile(
                                            context: context,
                                            code: item.code ?? '',
                                            name: item.name ?? '',
                                            onPressed: () {
                                              outTransferController
                                                  .selectTransferType(index);
                                              Navigator.pop(context);
                                            });
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 8,
                                          ),
                                      itemCount: outTransferController
                                          .transferTypeList.length));
                            },
                          ),
                        ],
                      ),
                    ))),
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
                  return outTransferController.inventoryItemList.isEmpty
                      ? const Center(
                          child: Text(
                            "No Data. Click add button to add details",
                            style: TextStyle(color: AppColors.mutedColor),
                          ),
                        )
                      : Expanded(
                          child: GetBuilder<OutTransferController>(
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
                                                  icon: Icons.mode_edit_outlined,
                                                  onPressed: (_) {
                                                    log("${item.unitList!.length} length");
                                                    
            
                                                    // outTransferController. productUnitList.value = item.unitList ?? [];
                                                    outTransferController
                                                        .getDataToUpdate(item,
                                                            item.unitList ?? []);
                                                    CommonWidgets.commonDialog(
                                                        context,
                                                        "${item.product?.description ?? ''}",
                                                        AddUpdateItem(
                                                          units:
                                                              item.unitList ?? [],
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
                                                                    outTransferController
                                                                        .updateItem(
                                                                      index,
                                                                    );
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  type: ButtonTypes
                                                                      .Primary,
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
                                                backgroundColor:
                                                    Colors.transparent,
                                                foregroundColor: Colors.red,
                                                icon: Icons.delete,
                                                onPressed: (_) =>
                                                    outTransferController
                                                        .deleteItem(index),
                                              ),
                                            ],
                                          ),
                                          child: GestureDetector(
                                              onDoubleTap: () {
                                                // itemDetailsController
                                                //     .updateValuesFromInventory(
                                                //         outTransferCOntroller
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
            key: const Key('out_transfer'),
            onTap: () {
              Get.to(() => OutTransferItemListScreen());
              outTransferController.getProductList();
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
                        'Do you want to close Transfer Out ? This actioln will clear current data'),
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
                  Get.delete<OutTransferController>();
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
                    //outTransferController.createTransferOut();
                    outTransferController.saveOutTransferInLocal();
                  },
                      type: ButtonTypes.Primary,
                      text: 'Save',
                      isLoading: outTransferController.isSaving.value)),
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
}
