import 'package:axolon_inventory_manager/controller/App%20Controls/stock_take_controller.dart';
import 'package:axolon_inventory_manager/controller/Local%20Db%20Controls/draft_list_controller.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/services/Api%20Services/common_api_service.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/Calculations/date_range_selector.dart';
import 'package:axolon_inventory_manager/utils/Calculations/inventory_calculations.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Components/dragging_button.dart';
import 'package:axolon_inventory_manager/view/Stock%20Take%20Screen/stock_take_item_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockTakeScreen extends StatelessWidget {
  StockTakeScreen({super.key});
  final stockTakeController = Get.put(StockTakeController());
  final draftListController = Get.put(DraftListController());
  var selectedSysdocValue;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (stockTakeController.isDraftsChecked.value == false) {
        await draftListController.getDraftItemList(
            option: DraftItemOption.StockTake);
        if (draftListController.draftItemList.isNotEmpty) {
          final isConfirm = await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: new Text('Are you sure?',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold)),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Do you want to load the existing items to grid ?'),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Obx(() => Checkbox(
                            activeColor: AppColors.primary,
                            value: stockTakeController.clearDataToggle.value,
                            onChanged: (value) {
                              stockTakeController.clearDataToggle.value =
                                  !stockTakeController.clearDataToggle.value;
                            },
                          )),
                      Text('Clear Existing Data'),
                    ],
                  ),
                ],
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              actions: <Widget>[
                InkWell(
                    onTap: () {
                      if (stockTakeController.clearDataToggle.value) {
                        draftListController.deleteDraftItemList(
                            draftOption: DraftItemOption.StockTake.value);
                      }

                      Navigator.of(context).pop(false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Cancel',
                          style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                              fontWeight: FontWeight.bold)),
                    )),
                InkWell(
                    onTap: () {
                      // if (stockTakeController.clearDataToggle.value) {
                      //   draftListController.deleteDraftItemList(
                      //       draftOption: DraftItemOption.StockTake.value);
                      // }
                      if (stockTakeController.clearDataToggle.value) {
                        draftListController.deleteDraftItemList(
                            draftOption: DraftItemOption.StockTake.value);
                      }

                      Navigator.of(context).pop(true);
                    },
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
            stockTakeController.fetchItems();
          }
        }
        stockTakeController.isDraftsChecked.value = true;
        stockTakeController.update();
      }
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Stock Take"),
      ),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
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
                                                stockTakeController
                                                    .sysDocList[index];
                                            return CommonWidgets.commonListTile(
                                                context: context,
                                                code: item.code ?? '',
                                                name: item.name ?? '',
                                                onPressed: () {
                                                  stockTakeController
                                                      .selectSyDoc(index);
                                                  Navigator.pop(context);
                                                });
                                          },
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: 8,
                                              ),
                                          itemCount: stockTakeController
                                              .sysDocList.length));
                                },
                                controller: TextEditingController(
                                    text:
                                        '${stockTakeController.selectedSysDoc.value.code} - ${stockTakeController.selectedSysDoc.value.name}'),
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
                              stockTakeController.voucherNumber.value,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CommonWidgets.textField(
                      context,
                      suffixicon: false,
                      readonly: false,
                      keyboardtype: TextInputType.text,
                      ontap: () {},
                      controller:
                          stockTakeController.descriptionController.value,
                      label: 'Description',
                      onchanged: (value) {},
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Stock",
                          style: TextStyle(
                              color: AppColors.mutedColor, fontSize: 15),
                        ),
                        FloatingActionButton(
                          mini: true,
                          onPressed: () {
                            // Get.to(() => MyWidget());
                            stockTakeController.getListStockSnapShot();
                            CommonWidgets.commonDialog(
                                context,
                                'Create From Stock Snapshot',
                                createStockTake(context), ontapOfClose: () {
                              stockTakeController.searchController.value
                                  .clear();
                              stockTakeController.selectedStatus.value =
                                  "Select";
                              Navigator.pop(context);
                            });
                          },
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            Icons.add,
                            color: AppColors.white,
                          ),
                          shape: CircleBorder(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CommonWidgets.common4TabHeader(
                        context,
                        'Code',
                        'Name',
                        'Onhand',
                        'Phys Qty',
                        fifthHead: 'Adjst Qty',
                        1,
                        1),
                    SizedBox(
                      height: 10,
                    ),
                    GetBuilder<StockTakeController>(
                        builder: (controllers) => controllers
                                .isLoadingItems.value
                            ? CommonWidgets.popShimmer()
                            : controllers.stockItems.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Data. Click add button to add details",
                                      style: TextStyle(
                                          color: AppColors.mutedColor),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              height: 10,
                                            ),
                                        itemCount:
                                            controllers.stockItems.length,
                                        physics: ScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var item =
                                              controllers.stockItems[index];
                                          return InkWell(
                                            onTap: () {
                                              stockTakeController
                                                      .physicalQuantity
                                                      .value
                                                      .text =
                                                  "${item.physicalQuantity.toString().contains('.') ? item.physicalQuantity : item.physicalQuantity.toDouble()}";
                                              CommonWidgets.commonDialog(
                                                context,
                                                "Onhand Qty : ${item.quantity}",
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: CommonWidgets.textField(
                                                              context,
                                                              suffixicon: false,
                                                              readonly: false,
                                                              controller:
                                                                  stockTakeController
                                                                      .physicalQuantity
                                                                      .value,
                                                              onchanged:
                                                                  (value) {
                                                                stockTakeController
                                                                    .editPhysicalQuantity(
                                                                        value);
                                                              },
                                                              keyboardtype: TextInputType
                                                                  .numberWithOptions(
                                                                      decimal:
                                                                          true),
                                                              label:
                                                                  "Physical Qty",
                                                              ontap: () =>
                                                                  stockTakeController
                                                                      .physicalQuantity
                                                                      .value
                                                                      .selectAll()),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        CommonWidgets
                                                            .elevatedButton(
                                                                context,
                                                                onTap: () {
                                                          stockTakeController
                                                              .setPhysicalQty(
                                                                  index);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                                type: ButtonTypes
                                                                    .Primary,
                                                                text: "Save")
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "${item.productId ?? ''}",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.mutedColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "${item.description ?? ''}",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.mutedColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.quantity != null
                                                        ? InventoryCalculations
                                                            .roundOffQuantity(
                                                                quantity: item
                                                                    .quantity)
                                                        : "0.00",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.mutedColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.physicalQuantity !=
                                                            null
                                                        ? InventoryCalculations
                                                            .roundOffQuantity(
                                                                quantity: item
                                                                    .physicalQuantity)
                                                        : "0.00",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.mutedColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    InventoryCalculations
                                                        .roundOffQuantity(
                                                            quantity: (item
                                                                        .quantity ??
                                                                    0) -
                                                                (item.physicalQuantity ??
                                                                    0)),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          AppColors.mutedColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ))
                  ])),
          DragableButton(
            key: const Key('stock_take'),
            onTap: () {
              CommonWidgets.commonDialog(context, '', StockTakeItemPicker(),
                  ontapOfClose: () {
                Navigator.pop(context);
                stockTakeController.resetQuantity();
                stockTakeController.itemCode.value.clear();
                stockTakeController.resetProduct();
              });
            },
            icon: const Icon(
              Icons.qr_code_rounded,
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
                        'Do you want to close ${"Stock snapshot"} ? This actioln will clear current data'),
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
                  Get.delete<StockTakeController>();
                  // Get.back();
                  Navigator.pop(context);
                }
                // Navigator.pop(context);
              }, type: ButtonTypes.Secondary, text: 'Cancel', isLoading: false),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Obx(() => CommonWidgets.elevatedButton(context,
                      onTap: () async {
                    bool isConnected = await ApiManager.isConnected();
                    if (isConnected) {
                      stockTakeController.createStockSnapshot();
                    } else {
                      stockTakeController.saveStockSnapshotInLocal();
                    }
                  },
                      type: ButtonTypes.Primary,
                      text: 'Save',
                      isLoading: stockTakeController.isSaving.value)),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget createStockTake(BuildContext context) {
    stockTakeController.filterStockSnapListAll();
    return Column(mainAxisSize: MainAxisSize.min, children: [
      CommonWidgets.textField(context,
          suffixicon: false,
          readonly: false,
          keyboardtype: TextInputType.text,
          label: 'Search', onchanged: (value) {
        stockTakeController.filterStockSnapListAll();
      }, controller: stockTakeController.searchController.value),
      SizedBox(
        height: 10,
      ),
      Obx(() => CommonWidgets.commonDateFilter(
              context,
              stockTakeController.dateIndex.value,
              stockTakeController.isToDate.value,
              stockTakeController.isFromDate.value,
              stockTakeController.fromDate.value,
              stockTakeController.toDate.value, (value) async {
            selectedSysdocValue = value;
            await stockTakeController.selectDateRange(selectedSysdocValue.value,
                DateRangeSelector.dateRange.indexOf(selectedSysdocValue));
            stockTakeController.filterStockSnapListAll();
          }, () async {
            await stockTakeController.selectDate(
                context, stockTakeController.isFromDate.value);
            stockTakeController.filterStockSnapListAll();
          })),
      SizedBox(
        height: 10,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        child: CommonWidgets.dropDown(context,
            selectedValue: stockTakeController.statusList.first,
            values: stockTakeController.statusList, onChanged: (value) {
          stockTakeController.selectedStatus.value = value;
          stockTakeController.filterStockSnapListAll();
        }, isName: false),
      ),
      SizedBox(
        height: 10,
      ),
      Expanded(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Obx(() => stockTakeController.isLoading.value
              ? CommonWidgets.popShimmer()
              : stockTakeController.filterStockSnapList.length == 0
                  ? Center(
                      child: Text(
                        'No Data Found',
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: stockTakeController.filterStockSnapList.length,
                      itemBuilder: (context, index) {
                        var item =
                            stockTakeController.filterStockSnapList[index];
                        return InkWell(
                          onTap: () {
                            stockTakeController.getStockSnapShotById(item);
                            Navigator.pop(context);
                          },
                          child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.sysDocId} - ${item.voucherId}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Date : ${DateFormatter.dateFormat.format(item.transactionDate)}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Location : ${item.locationId}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Description : ${item.description ?? ""}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Planned Date : ${item.planedDate != null ? DateFormatter.dateFormat.format(item.planedDate) : ""}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ))),
        ),
      )
    ]);
  }
}
