import 'dart:ffi';
import 'dart:io';

import 'package:axolon_inventory_manager/controller/App%20Controls/in_transfer_controller.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../utils/constants/snackbar.dart';
import '../Components/common_widgets.dart';

class InTransferItemPicker extends StatefulWidget {
  const InTransferItemPicker({super.key});

  @override
  State<InTransferItemPicker> createState() => _InTransferItemPickerState();
}

class _InTransferItemPickerState extends State<InTransferItemPicker> {
  FocusNode focus = FocusNode();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final intransferController = Get.put(InTransferController());
  // final stockTakeController = Get.put(StockTakeController());

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
                      groupValue: intransferController.selectedValue.value,
                      onChanged: (value) {
                        intransferController.selectValue(value);
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
                      groupValue: intransferController.selectedValue.value,
                      onChanged: (value) {
                        intransferController.selectValue(value);
                        focus.unfocus();
                      },
                    )),
              ],
            )
          ],
        ),
        Obx(() => SizedBox(
            height: intransferController.selectedValue == 2
                ? 0
                : MediaQuery.of(context).size.width * 0.8,
            child: intransferController.selectedValue == 2
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
          height: 30,
        ),
        Row(
          children: [
            Expanded(
              child: Obx(() => TextField(
                    onChanged: (p0) {
                      if (p0.isNotEmpty) {}
                    },
                    onTap: () {},
                    focusNode: focus,
                    controller: intransferController.itemCode.value,
                    // readOnly: intransferController.selectedValue.value == 1
                    //     ? true
                    //     : false,
                    readOnly: false,
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
                intransferController.itemCode.value.clear();

                controller!.resumeCamera();
              }, type: ButtonTypes.Secondary, text: 'Reset', isLoading: false),
            )
          ],
        ),
      ]),
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
      controller.pauseCamera();
      if (result != null && result!.code != null) {
        String scannedCode = result!.code!;
        intransferController.itemCode.value.text = scannedCode;
        int index = intransferController.transferItemList.indexWhere((item) {
          return item.productId == scannedCode;
        });

        if (index != -1) {
          if (intransferController.transferItemList[index].acceptedQuantity ==
              null) {
            intransferController.transferItemList[index].acceptedQuantity = 1;
            controller.resumeCamera();
            intransferController.itemCode.value.clear();
          } else {
            if (intransferController.transferItemList[index].quantity ==
                intransferController.transferItemList[index].acceptedQuantity) {
              SnackbarServices.errorSnackbar(
                  'Accepeted quantity Should not exceed transfer quantity');
              return;
            }
            intransferController.transferItemList[index].acceptedQuantity++;
            controller.resumeCamera();
            intransferController.itemCode.value.clear();
          }
        } else {
          SnackbarServices.errorSnackbar('Item could not find in the list');
        }

        intransferController.update();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
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
