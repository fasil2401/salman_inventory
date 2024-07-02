import 'package:axolon_inventory_manager/controller/App%20Controls/in_transfer_controller.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/system_document_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/In%20Transfer%20Screen/in_transfer_item_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../Components/dragging_button.dart';
import '../Stock Take Screen/stock_take_item_picker.dart';

class InTransferScreen extends StatelessWidget {
  InTransferScreen({super.key});
  final inTransferController = Get.put(InTransferController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("In Transfer"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => CommonWidgets.textField(
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
                                        SysDocModel item = inTransferController
                                            .sysDocList[index];
                                        return CommonWidgets.commonListTile(
                                            context: context,
                                            code: item.code ?? '',
                                            name: item.name ?? '',
                                            onPressed: () {
                                              inTransferController
                                                  .selectSyDoc(index);
                                              Navigator.pop(context);
                                            });
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 8,
                                          ),
                                      itemCount: inTransferController
                                          .sysDocList.length));
                            },
                            controller: TextEditingController(
                                text:
                                    '${inTransferController.selectedSysDoc.value.code} - ${inTransferController.selectedSysDoc.value.name}'),
                            label: 'SysDocId',
                            onchanged: (value) {},
                          ),
                        ),
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
                      Obx(
                        () => Text(
                          inTransferController.voucherNumber.value,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primary),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(() => InkWell(
                      onTap: () {
                        inTransferController.openAccordian();
                      },
                      child: GFAccordion(
                        margin: EdgeInsets.all(0),
                        showAccordion:
                            inTransferController.isOpenAccordian.value,
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
                                  text: DateFormatter.dateFormat
                                      .format(inTransferController.date.value)),
                              label: 'Date',
                              ontap: () async {
                                DateTime newDate =
                                    await CommonWidgets.getCalender(context,
                                            inTransferController.date.value) ??
                                        DateTime.now();
                                inTransferController.selectDate(newDate);
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
                                      '${inTransferController.selectedLocation.value.code} - ${inTransferController.selectedLocation.value.name}'),
                              label: 'Location To',
                              ontap: () {
                                CommonWidgets.commonDialog(
                                    context,
                                    'Locations',
                                    ListView.separated(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          LocationModel item =
                                              inTransferController
                                                  .locationList[index];
                                          return CommonWidgets.commonListTile(
                                              context: context,
                                              code: item.code ?? '',
                                              name: item.name ?? '',
                                              onPressed: () {
                                                inTransferController
                                                    .selectLocation(index);
                                                Navigator.pop(context);
                                              });
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              height: 8,
                                            ),
                                        itemCount: inTransferController
                                            .locationList.length));
                              },
                              onchanged: (value) {},
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CommonWidgets.textField(
                                    context,
                                    suffixicon: false,
                                    readonly: true,
                                    keyboardtype: TextInputType.datetime,
                                    controller: inTransferController
                                        .transferDateController.value,
                                    label: 'Transfer Date',
                                    ontap: () {},
                                    onchanged: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Obx(
                                    () => CommonWidgets.textField(
                                      context,
                                      suffixicon: false,
                                      readonly: false,
                                      keyboardtype:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      controller: inTransferController
                                          .totalTransferQuantityController
                                          .value,
                                      // text: inTransferController
                                      //     .selectedInTransferVoucherbyid.value.sysDocId
                                      //     .toString(),

                                      label: 'Total Transfer Quantity',
                                      ontap: () {},
                                      onchanged: (value) {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => CommonWidgets.textField(
                                      context,
                                      suffixicon: false,
                                      readonly: false,
                                      keyboardtype:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      controller: inTransferController
                                          .totalAcceptedQuantityController
                                          .value,
                                      label: 'Total Accepted Quantity',
                                      ontap: () {},
                                      onchanged: (value) {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Obx(
                                    () => CommonWidgets.textField(
                                      context,
                                      suffixicon: false,
                                      readonly: false,
                                      keyboardtype:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      controller: TextEditingController(
                                        text: inTransferController
                                            .totalShortQty.value
                                            .toString(),
                                      ),
                                      // controller:inTransferController.totalShortQuantityController.value,
                                      // TextEditingController(
                                      //   text: inTransferController
                                      //       .totalShortQty.value
                                      //       .toString(),
                                      //  ),
                                      label: 'Total Short Quantity',
                                      ontap: () {},
                                      onchanged: (value) {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Text(
                          inTransferController
                                  .selectedInTransferVoucher.value.number ??
                              "Transfer Number",
                          style: TextStyle(
                              color: AppColors.mutedColor, fontSize: 15),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          inTransferController
                              .getInventoryTransferToAccept(context);
                          CommonWidgets.commonDialog(
                            context,
                            "Vouchers",
                            getVoucherDialogue(context),
                          );
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
                  Divider(
                    color: AppColors.mutedColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CommonWidgets.elevatedButton(context,
                        onTap: () async {
                      await inTransferController.recieveAll();
                    },
                        type: ButtonTypes.Primary,
                        isLoading: false,
                        text: 'Receive All'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CommonWidgets.common4TabHeader(
                      context, 'Code', 'Name', 'Trans Qty', 'Acc Qty', 2, 1),
                  SizedBox(
                    height: 10,
                  ),
                  getItemList(context, width),
                  // Center(
                  //   child: Text(
                  //     "No Data. Click add button to add details",
                  //     style: TextStyle(color: AppColors.mutedColor),
                  //   ),
                  // ),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: DragableButton(
              key: const Key('in_transfer'),
              onTap: () {
                if (inTransferController.transferItemList.isEmpty) {
                  SnackbarServices.errorSnackbar(
                      'Please select any transaction');
                  return;
                }
                CommonWidgets.commonDialog(context, '', InTransferItemPicker(),
                    ontapOfClose: () {
                  inTransferController.itemCode.value.clear();
                  ;
                  Navigator.pop(context);
                });
              },
              icon: const Icon(
                Icons.qr_code_rounded,
                color: Colors.white,
              ),
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
                        'Do you want to close Transfer In ? This actioln will clear current data'),
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
                  Get.delete<InTransferController>();
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
                    inTransferController
                                .selectedInTransferVoucher.value.number ==
                            null
                        ? SnackbarServices.errorSnackbar(
                            ' Please add items to transfer')
                        : inTransferController.createIntransfer();
                  },
                      type: ButtonTypes.Primary,
                      text: 'Save',
                      isLoading: inTransferController.isSaving.value)),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  getVoucherDialogue(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GetBuilder<InTransferController>(builder: (controller) {
        return controller.isLoading.value
            ? CommonWidgets.popShimmer()
            : ListView.separated(
                shrinkWrap: true,
                itemCount: controller.vouchersList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var item = inTransferController.vouchersList[index];
                  return InkWell(
                    onTap: () async {
                      inTransferController.selectInventoryTransfer(item);

                      print(
                          "Date: ${inTransferController.selectedVoucherDate.value}");
                      print(
                          "Inventory${inTransferController.selectedVoucher.value}");
                      print(
                          "itenumber${inTransferController.selectedSysDocnumber.value}");
                      Navigator.pop(context);
                    },
                    child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${item.number} - ${item.sysDocId}',
                                style: const TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              smalltext(
                                context,
                                title: 'Description: ${item.description}',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              smalltext(
                                context,
                                title: 'Date: ${item.date.toString()}',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              smalltext(
                                context,
                                title: 'From: ${item.from}',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              smalltext(
                                context,
                                title: 'To: ${item.to}',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              smalltext(
                                context,
                                title: 'Reason: ${item.reason.toString()}',
                              ),
                            ],
                          ),
                        )),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 2,
                ),
              );
      }),
    );
  }

  Widget smalltext(BuildContext context, {required String title}) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Rubik',
        color: mutedColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  getItemList(BuildContext context, double width) {
    return GetBuilder<InTransferController>(builder: (controller) {
      return SizedBox(
          child: inTransferController.transferItemList.isEmpty
              ? Center(
                  child: Text(
                    "No Data. Click add button to add details",
                    style: TextStyle(color: AppColors.mutedColor),
                  ),
                )
              : Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: inTransferController.transferItemList.length,
                    itemBuilder: (context, index) {
                      var transferitem =
                          inTransferController.transferItemList[index];
                      return InkWell(
                        onTap: () => Get.defaultDialog(
                          title: 'Transfer Qty : ${transferitem.quantity}',
                          titlePadding: const EdgeInsets.all(10),
                          titleStyle: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: 18,
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: TextField(
                                  controller: inTransferController
                                      .acceptQtyController.value,
                                  onChanged: (value) {
                                    // inTransferController.editAcceptQuantity(value);
                                  },
                                  onEditingComplete: () {
                                    inTransferController.setAcceptedQty(
                                        index, context);
                                  },
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).highlightColor),
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: mutedColor, width: 0.1),
                                    ),
                                    labelText: 'Accepted Qty',
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  inTransferController.setAcceptedQty(
                                      index, context);
                                  // Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Obx(
                                      () => inTransferController.isSaving.value
                                          ? const SizedBox(
                                              height: 15,
                                              width: 15,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                              ),
                                            )
                                          : Text(
                                              'Save',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Rubik',
                                                fontSize: 16,
                                              ),
                                            )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  width: width * 0.1,
                                  child: Text(
                                    transferitem.productId.toString(),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  transferitem.description.toString(),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  width: width * 0.13,
                                  child: Text(
                                    transferitem.quantity.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  width: width * 0.13,
                                  child: Text(
                                    transferitem.acceptedQuantity.toString() ==
                                            'null'
                                        ? '0'
                                        : transferitem.acceptedQuantity
                                            .toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ));
    });
  }
}
