import 'dart:developer';
import 'dart:io';

import 'package:axolon_inventory_manager/controller/App%20Controls/stock_take_controller.dart';
import 'package:axolon_inventory_manager/model/Stock%20Take%20Model/stock_snapshot_byid_model.dart';
import 'package:axolon_inventory_manager/model/draft_items_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Stock%20Take%20Screen/stock_take_item_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class StockTakeItemPicker extends StatefulWidget {
  const StockTakeItemPicker({super.key});

  @override
  State<StockTakeItemPicker> createState() => _StockTakeItemPickerState();
}

class _StockTakeItemPickerState extends State<StockTakeItemPicker> {
  FocusNode focus = FocusNode();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final stockTakeController = Get.put(StockTakeController());
  TextEditingController textController = TextEditingController();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else {
      controller!.resumeCamera();
    }
  }

  int count = 1003;

  @override
  void initState() {
    super.initState();
    log("${UserSimplePreferences.getIsDirectAddItemDisabled()} preference");

    stockTakeController
        .selectValue(UserSimplePreferences.getIsCameraDisabled() ?? 1);
    stockTakeController.directAddItem.value =
        UserSimplePreferences.getIsDirectAddItemDisabled() != null &&
                UserSimplePreferences.getIsDirectAddItemDisabled() == 1
            ? true
            : false;
    if (stockTakeController.selectedValue == 2) {
      focus.requestFocus();
    }
    log("${stockTakeController.directAddItem.value}  directAddItem");
  }

  void _handleKeyboardEvent(RawKeyEvent event) {
    stockTakeController.itemCode.value.clear();
    stockTakeController.product.value = ProductListModel();
    String scannedData = '';
    if (event.runtimeType == RawKeyUpEvent) {
      // Process scanner input when a key is released
      scannedData = event.data.logicalKey.keyLabel;
      // SnackbarServices.successSnackbar(scannedData);
      // scannedData = count.toString();
      stockTakeController.stockItems.isNotEmpty
          ? stockTakeController.scanToAddIncreaseStockItem(scannedData)
          : stockTakeController.scanToAddStockItem(scannedData);
      if (stockTakeController.directAddItem.value) {
        var product = stockTakeController.product.value;
        if (product.productId == null) {
          return;
        }
        log("handling keyboard");
        stockTakeController.addStockItem(StockDetailModel(
          description: product.description,
          productId: product.productId,
          quantity: product.quantity,
          physicalQuantity: stockTakeController.quantity.value,
          unitId: product.unitId,
          remarks: null,
        ));

        // stockTakeController.resetQuantity();
        // stockTakeController.resetProduct();
        // stockTakeController.itemCode.value.clear();
        setState(() {
          focus.requestFocus();
        });
      }

      // if (stockTakeController.selectedValue.value == 1) {
      //   controller!.resumeCamera();
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text('Scanner'),
                Obx(() => Radio(
                      value: 2,
                      activeColor: Theme.of(context).primaryColor,
                      groupValue: stockTakeController.selectedValue.value,
                      onChanged: (value) {
                        stockTakeController.selectValue(value);
                        focus.requestFocus();
                      },
                    )),
              ],
            ),
            Row(
              children: [
                Text('Camera'),
                Obx(() => Radio(
                      value: 1,
                      activeColor: Theme.of(context).primaryColor,
                      groupValue: stockTakeController.selectedValue.value,
                      onChanged: (value) {
                        stockTakeController.selectValue(value);
                        focus.unfocus();
                      },
                    )),
              ],
            )
          ],
        ),
        Obx(() => SizedBox(
            height: stockTakeController.selectedValue == 2
                ? 0
                : MediaQuery.of(context).size.width * 0.8,
            child: stockTakeController.selectedValue == 2
                ? Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      backgroundBlendMode: BlendMode.clear,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_rounded,
                              size: 0,
                              color: mutedColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Sacnning Mode')
                          ],
                        ),
                      ),
                    ),
                  )
                : _buildQrView(context))),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  stockTakeController.getDraftList();
                  CommonWidgets.commonDialog(context, "Recently Scanned",
                      GetBuilder<StockTakeController>(
                    builder: (_) {
                      return ListView.builder(
                        itemCount: _.draftList.length,
                        itemBuilder: (context, index) {
                          DraftItemListModel item = _.draftList[index];
                          return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              shadowColor: Colors.black,
                              elevation: 10,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${item.productId ?? ''}",
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Flexible(
                                                  child: Text(
                                                " - ${item.description ?? ''}",
                                                style: TextStyle(
                                                    color: AppColors.mutedColor,
                                                    fontSize: 12),
                                              ))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${item.sysDocId ?? ''}",
                                                style: TextStyle(
                                                  color: AppColors.mutedColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                "${item.voucherId ?? ''}",
                                                style: TextStyle(
                                                    color: AppColors.mutedColor,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ],
                                      ))));
                        },
                      );
                    },
                  ));
                },
                child: Icon(
                  Icons.history_outlined,
                  weight: 0.05,
                  // opticalSize: 0.5,
                  size: 26,
                  color: AppColors.mutedColor,
                )),
            Row(
              children: [
                Text(
                  "Direct Add Item",
                  // minFontSize: 12,
                  // maxFontSize: 14,
                  style: TextStyle(
                    fontSize: 12,
                    color: mutedColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() => Switch(
                        value: stockTakeController.directAddItem.value,
                        activeColor: commonBlueColor,
                        onChanged: (value) =>
                            stockTakeController.toggleDirectAddItem(),
                      )),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Obx(() => TextField(
                    onChanged: (p0) async {
                      if (textController.text.isNotEmpty) {
                        stockTakeController.stockItems.isNotEmpty
                            ? await stockTakeController
                                .scanToAddIncreaseStockItem(
                                    textController.text.trim())
                            : await stockTakeController
                                .scanToAddStockItem(textController.text.trim());
                        // stockTakeController.stockItems.isNotEmpty
                        //     ? stockTakeController
                        //         .scanToAddIncreaseStockItem(scannedData)
                        //     : stockTakeController
                        //         .scanToAddStockItem(scannedData);
                        if (stockTakeController.directAddItem.value) {
                          var product = stockTakeController.product.value;
                          if (product.productId == null) {
                            return;
                          }
                          await stockTakeController
                              .addStockItem(StockDetailModel(
                            description: product.description,
                            productId: product.productId,
                            quantity: product.quantity,
                            physicalQuantity:
                                stockTakeController.quantity.value,
                            unitId: product.unitId,
                            remarks: null,
                          ));
                        }
                        textController.clear();
                      }
                    },
                    onTap: () {
                      textController.clear();
                    },
                    focusNode: focus,
                    controller: textController,
                    readOnly: stockTakeController.selectedValue.value == 1
                        ? true
                        : false,
                    // readOnly: true,
                    style: TextStyle(fontSize: 12, color: mutedColor),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      isCollapsed: true,
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: mutedColor, width: 0.1),
                      ),
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
                      labelText: 'Item Code',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor,
                      ),
                      suffixIconConstraints:
                          BoxConstraints.tightFor(height: 30, width: 30),
                    ),
                  )),
            ),
            InkWell(
              onTap: () {
                // _handleKeyboardEvent(RawKeyUpEvent(
                //     data: RawKeyEventDataAndroid(), character: '122333'));
                // setState(() {
                //   count += 1;
                // });

                Navigator.pop(context);
                Get.to(() => StockTakeItemListScreen());
                stockTakeController.getProductList();
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
        SizedBox(
          height: 15,
        ),
        Obx(() => CommonWidgets.textField(
              context,
              suffixicon: false,
              readonly: true,
              keyboardtype: TextInputType.text,
              controller: TextEditingController(
                  text:
                      "${stockTakeController.product.value.productId ?? ''} - ${stockTakeController.product.value.description ?? ''}"),
              label: 'Item Name',
            )),
        SizedBox(
          height: 15,
        ),
        Obx(() => CommonWidgets.textField(context,
                    suffixicon: false,
                    readonly: true,
                    keyboardtype: TextInputType.text,
                    controller: stockTakeController.unitIdCtrl.value,
                    label: "Units", ontap: () {
                  CommonWidgets.commonDialog(context, "Units", unitPopup());
                })
            // CommonWidgets.textField(context,
            //     suffixicon: false,
            //     readonly: true,
            //     keyboardtype: TextInputType.text,
            //     controller: TextEditingController(
            //      // text: "${stockTakeController.selectedUnit.value.name ?? ""}"
            //         text: "${stockTakeController.product.value.unitId ?? ''}"
            //         ),
            //     label: 'Unit',
            //     ontap: () {
            //        CommonWidgets.commonDialog(
            //                     context, "Unit", _selectUnitPop(context));
            //     })
            ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Quantity',
                    style: TextStyle(color: AppColors.mutedColor, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          stockTakeController.decrementQuantity();
                        },
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 15,
                          child: const Center(child: Icon(Icons.remove)),
                        ),
                      ),
                      Obx(
                        () {
                          stockTakeController.quantityControl.value.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: stockTakeController
                                      .quantityControl.value.text.length));
                          return Flexible(
                            child: stockTakeController.isEditingQuantity.value
                                ? TextField(
                                    autofocus: false,
                                    controller: stockTakeController
                                        .quantityControl.value,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    onChanged: (value) {
                                      stockTakeController.setQuantity(value);
                                    },
                                    onTap: () {
                                      stockTakeController.quantityControl.value
                                          .selectAll();
                                    },
                                  )
                                : Obx(() => InkWell(
                                      onTap: () {
                                        stockTakeController.editQuantity();
                                        stockTakeController
                                                .quantityControl.value.text =
                                            stockTakeController.quantity.value
                                                .toString();
                                      },
                                      child: Text(stockTakeController
                                          .quantity.value
                                          .toString()),
                                    )),
                          );
                        },
                      ),
                      InkWell(
                        onTap: () {
                          stockTakeController.incrementQuantity();
                        },
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 15,
                          child: const Center(child: Icon(Icons.add)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Stock',
                  style: TextStyle(color: AppColors.mutedColor, fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => Text(
                    "${stockTakeController.product.value.quantity ?? 0.0}"))
              ],
            ))
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CommonWidgets.elevatedButton(context, onTap: () {
                stockTakeController.resetProduct();
                stockTakeController.itemCode.value.clear();
                setState(() {
                  focus.requestFocus();
                });
                if (stockTakeController.selectedValue.value == 1) {
                  controller!.resumeCamera();
                }
              }, type: ButtonTypes.Secondary, text: 'Clear', isLoading: false),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CommonWidgets.elevatedButton(context, onTap: () {
                var product = stockTakeController.product.value;
                if (product.productId == null) {
                  return;
                }
                stockTakeController.addStockItem(StockDetailModel(
                  description: product.description,
                  productId: product.productId,
                  quantity: product.quantity,
                  physicalQuantity: stockTakeController.quantity.value,
                  unitId: product.unitId,
                  remarks: null,
                ));

                stockTakeController.resetQuantity();
                stockTakeController.resetProduct();
                stockTakeController.itemCode.value.clear();
                setState(() {
                  focus.requestFocus();
                });
                if (stockTakeController.selectedValue.value == 1) {
                  controller!.resumeCamera();
                }
              }, type: ButtonTypes.Primary, text: 'Add', isLoading: false),
            )
          ],
        ),
      ]),
    );
  }

  unitPopup() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child:
              //stockTakeController.productUnitList.isEmpty
              //  ? GetBuilder<StockTakeController>(
              //     init: StockTakeController(),
              //     initState: (_) {},
              //     builder: (_) {
              //       return
              //        ListView.separated(
              //           separatorBuilder: (context, index) => Divider(),
              //           itemCount: _.productList.length,
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) {

              //             var item = _.productList[index];
              //             return InkWell(
              //               onTap: () {
              //                 _.unitIdCtrl.value.text = "${item.unitId ?? ''}";
              //                 // stockTakeController.selectUnit(item);
              //                 Navigator.pop(context);
              //               },
              //               child: Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text("${item.unitId}"),
              //               ),
              //             );
              //           });
              //     },
              //   )
              GetBuilder<StockTakeController>(
            init: StockTakeController(),
            initState: (_) {},
            builder: (_) {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: _.productUnitList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = _.productUnitList[index];
                    return InkWell(
                      onTap: () {
                        _.unitIdCtrl.value.text = "${item.code ?? ''}";
                        stockTakeController.selectUnit(item);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${item.code}"),
                      ),
                    );
                  });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width * 0.8
        : MediaQuery.of(context).size.width * 0.8;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          overlayColor: Colors.white,
          borderColor: Theme.of(context).primaryColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.resumeCamera();
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      // log("${scanData.code} scandata");
      // log("${result!.code} result");

      controller.pauseCamera();
      stockTakeController.stockItems.isNotEmpty
          ? await stockTakeController.scanToAddIncreaseStockItem(result!.code!)
          : await stockTakeController.scanToAddStockItem(result!.code!);
      if (stockTakeController.directAddItem.value) {
        ProductListModel product = stockTakeController.product.value;
        if (product.productId == null) {
          return;
        }
        stockTakeController.addStockItem(StockDetailModel(
          description: product.description,
          productId: product.productId,
          quantity: product.quantity,
          physicalQuantity: stockTakeController.quantity.value,
          unitId: product.unitId,
          remarks: null,
        ));

        stockTakeController.resetQuantity();
        stockTakeController.resetProduct();
        stockTakeController.itemCode.value.clear();
        setState(() {
          focus.requestFocus();
        });
        if (stockTakeController.selectedValue.value == 1) {
          controller.resumeCamera();
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    RawKeyboard.instance.removeListener(_handleKeyboardEvent);
    super.dispose();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}

extension TextEditingControllerExt on TextEditingController {
  void selectAll() {
    if (text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}
