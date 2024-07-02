import 'dart:developer';
import 'dart:io';
import 'package:axolon_inventory_manager/controller/App%20Controls/recieve_controller.dart';
import 'package:axolon_inventory_manager/model/Recieve%20Item%20Model/add_recieve_item_model.dart';
import 'package:axolon_inventory_manager/model/location_model.dart';
import 'package:axolon_inventory_manager/model/product_list_model.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/services/extensions.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Recieve%20Screen/recieve_item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class RecieveItemPicker extends StatefulWidget {
  const RecieveItemPicker({super.key});

  @override
  State<RecieveItemPicker> createState() => _RecieveItemPickerState();
}

class _RecieveItemPickerState extends State<RecieveItemPicker> {
  FocusNode focus = FocusNode();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final recieveController = Get.put(RecieveController());

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else {
      controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    log("${UserSimplePreferences.getIsDirectAddItemDisabled()} preference");

    recieveController
        .selectValue(UserSimplePreferences.getIsCameraDisabled() ?? 1);
    if (recieveController.selectedValue == 2) {
      focus.requestFocus();
    }
  }

  void _handleKeyboardEvent(RawKeyEvent event) {
    log("handling keyboard");
    if (event.runtimeType == RawKeyUpEvent) {
      // Process scanner input when a key is released
      final String scannedData = event.data.logicalKey.keyLabel;
      recieveController.recieveItemList.isNotEmpty
          ? recieveController.scanToAddIncreaseStockItem(scannedData)
          : recieveController.scanToAddStockItem(scannedData);
      // if (recieveController.directAddItem.value) {
      //   var product = recieveController.product.value;
      //   if (product.productId == null) {
      //     return;
      // //   }
      //   recieveController.addItem(AddItemRecieveModel(
      //     product: product,
      //     unitList: recieveController.productUnitList,
      //     updatedLocation: recieveController.selectedLocation.value,
      //     updatedQuantity:
      //         double.parse(recieveController.quantity.value.toString()),
      //     updatedUnit: recieveController.selectedUnit.value,
      //   ));

      //   // recieveController.resetQuantity();
      //   // recieveController.resetProduct();
      //   // recieveController.itemCode.value.clear();

      //   setState(() {
      //     focus.requestFocus();
      //   });
      // }

      // if (recieveController.selectedValue.value == 1) {
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
                      groupValue: recieveController.selectedValue.value,
                      onChanged: (value) {
                        recieveController.selectValue(value);
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
                      groupValue: recieveController.selectedValue.value,
                      onChanged: (value) {
                        recieveController.selectValue(value);
                        focus.unfocus();
                      },
                    )),
              ],
            )
          ],
        ),
        Obx(() => SizedBox(
            height: recieveController.selectedValue == 2
                ? 0
                : MediaQuery.of(context).size.width * 0.8,
            child: recieveController.selectedValue == 2
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
          children: [
            Expanded(
              child: Obx(() => TextField(
                    onChanged: (p0) {
                      if (p0.isNotEmpty) {
                        recieveController.recieveItemList.isNotEmpty
                            ? recieveController.scanToAddIncreaseStockItem(p0)
                            : recieveController.scanToAddStockItem(p0);
                      }
                    },
                    onTap: () {
                      recieveController.itemCode.value.clear();
                    },
                    focusNode: focus,
                    controller: recieveController.itemCode.value,
                    readOnly: recieveController.selectedValue.value == 1
                        ? true
                        : false,
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
                Navigator.pop(context);
                Get.to(() => RecieveItemListScreen());
                recieveController.getProductList();
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
                  text: "${recieveController.product.value.description ?? ''}"),
              label: 'Item Name',
            )),
        SizedBox(
          height: 15,
        ),
        Obx(() => CommonWidgets.textField(context,
                    suffixicon: false,
                    readonly: true,
                    keyboardtype: TextInputType.text,
                    controller: recieveController.unitIdCtrl.value,
                    label: "Units", ontap: () {
                  CommonWidgets.commonDialog(context, "Units", unitPopup());
                })
            // CommonWidgets.textField(context,
            //     suffixicon: false,
            //     readonly: true,
            //     keyboardtype: TextInputType.text,
            //     controller: TextEditingController(
            //      // text: "${recieveController.selectedUnit.value.name ?? ""}"
            //         text: "${recieveController.product.value.unitId ?? ''}"
            //         ),
            //     label: 'Unit',
            //     ontap: () {
            //        CommonWidgets.commonDialog(
            //                     context, "Unit", _selectUnitPop(context));
            //     })
            ),
        SizedBox(
          height: 15,
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
              ontap: () {
                CommonWidgets.commonDialog(
                    context,
                    'Locations',
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          LocationModel item =
                              recieveController.locationList[index];
                          return CommonWidgets.commonListTile(
                              context: context,
                              code: item.code ?? '',
                              name: item.name ?? '',
                              onPressed: () {
                                recieveController.selectLocation(index);
                                Navigator.pop(context);
                              });
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 8,
                            ),
                        itemCount: recieveController.locationList.length));
              },
            )),
        SizedBox(
          height: 15,
        ),
        CommonWidgets.textField(context,
            controller: recieveController.remarksController.value,
            suffixicon: false,
            readonly: false,
            keyboardtype: TextInputType.text,
            maxLength: null,
            maxLines: null,
            label: 'Remarks'),
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
                          recieveController.decrementQuantity();
                        },
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 15,
                          child: const Center(child: Icon(Icons.remove)),
                        ),
                      ),
                      Obx(
                        () {
                          recieveController.quantityControl.value.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: recieveController
                                      .quantityControl.value.text.length));
                          return Flexible(
                            child: recieveController.isEditingQuantity.value
                                ? TextField(
                                    autofocus: false,
                                    controller:
                                        recieveController.quantityControl.value,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ''),
                                    onChanged: (value) {
                                      recieveController.setQuantity(value);
                                    },
                                    onTap: () {
                                      recieveController.quantityControl.value
                                          .selectAll();
                                    },
                                  )
                                : Obx(() => InkWell(
                                      onTap: () {
                                        recieveController.editQuantity();
                                        recieveController
                                                .quantityControl.value.text =
                                            recieveController.quantity.value
                                                .toString();
                                      },
                                      child: Text(recieveController
                                          .quantity.value
                                          .toString()),
                                    )),
                          );
                        },
                      ),
                      InkWell(
                        onTap: () {
                          recieveController.incrementQuantity();
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
                Obx(() =>
                    Text("${recieveController.product.value.quantity ?? 0.0}"))
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
                recieveController.resetProduct();
                recieveController.itemCode.value.clear();
                setState(() {
                  focus.requestFocus();
                });
                if (recieveController.selectedValue.value == 1) {
                  controller!.resumeCamera();
                }
              }, type: ButtonTypes.Secondary, text: 'Clear', isLoading: false),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CommonWidgets.elevatedButton(context, onTap: () {
                var product = recieveController.product.value;
                if (product.productId == null) {
                  return;
                }
                recieveController.addItem(AddItemRecieveModel(
                    product: product,
                    unitList: recieveController.productUnitList,
                    updatedLocation: recieveController.selectedLocation.value,
                    updatedQuantity: double.parse(
                        recieveController.quantity.value.toString()),
                    updatedUnit: recieveController.selectedUnit.value,
                    remarks: recieveController.remarksController.value.text));

                recieveController.resetQuantity();
                recieveController.resetProduct();
                recieveController.itemCode.value.clear();
                setState(() {
                  focus.requestFocus();
                });
                if (recieveController.selectedValue.value == 1) {
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
              //recieveController.productUnitList.isEmpty
              //  ? GetBuilder<recieveController>(
              //     init: recieveController(),
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
              //                 // recieveController.selectUnit(item);
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
              GetBuilder<RecieveController>(
            init: RecieveController(),
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
                        recieveController.selectUnit(item);
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
      recieveController.recieveItemList.isNotEmpty
          ? await recieveController.scanToAddIncreaseStockItem(result!.code!)
          : await recieveController.scanToAddStockItem(result!.code!);
      // if (recieveController.directAddItem.value) {
      //   ProductListModel product = recieveController.product.value;
      //   if (product.productId == null) {
      //     return;
      //   }
      //   recieveController.addItem(AddItemRecieveModel(
      //     product: product,
      //     unitList: recieveController.productUnitList,
      //     updatedLocation: recieveController.selectedLocation.value,
      //     updatedQuantity:
      //         double.parse(recieveController.quantity.value.toString()),
      //     updatedUnit: recieveController.selectedUnit.value,
      //   ));

      //   recieveController.resetQuantity();
      //   recieveController.resetProduct();
      //   recieveController.itemCode.value.clear();
      //   setState(() {
      //     focus.requestFocus();
      //   });
      //   if (recieveController.selectedValue.value == 1) {
      //     controller.resumeCamera();
      //   }
      // }
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
