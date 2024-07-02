import 'dart:developer';
import 'dart:io';
import 'package:axolon_inventory_manager/controller/App%20Controls/direct_inventory_transfer_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/out_transfer_controller.dart';
import 'package:axolon_inventory_manager/services/enums.dart';
import 'package:axolon_inventory_manager/utils/constants/snackbar.dart';
import 'package:axolon_inventory_manager/view/Components/common_widgets.dart';
import 'package:axolon_inventory_manager/view/Out%20Transfer%20Screen/add_item_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class DirectInventoryTransferScan extends StatefulWidget {
  const DirectInventoryTransferScan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DirectInventoryTransferScanState();
}

class _DirectInventoryTransferScanState extends State<DirectInventoryTransferScan> {
    final directInventoryTransferController =
      Get.put(DirectInventoryTransferController());
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  bool flash = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else {
      controller!.resumeCamera();
    }
  }

  double height = 0.0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          controller!.toggleFlash();
          setState(() {
            flash = !flash;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              !flash ? Icons.light_mode_outlined : Icons.light_mode_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // controller?.resumeCamera();
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Theme.of(context).primaryColor,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  controller!.pauseCamera();
                  Navigator.pop(context);
                },
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
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
      log("${scanData.code} scandata");
      log("${result!.code} result");

      try {
        await directInventoryTransferController.scanItem(
          result!.code!,
        );

        CommonWidgets.commonDialog(
            context, directInventoryTransferController.itemName.value, AddUpdateItem(),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: CommonWidgets.elevatedButton(
                      context,
                      onTap: () {
                        directInventoryTransferController.addItem();
                        Navigator.pop(context);
                      },
                      type: ButtonTypes.Primary,
                      text: "Add",
                    ),
                  ),
                ],
              )
            ]);
        log("${directInventoryTransferController.selectedItem.value.description ?? ""} scandata");

        controller.pauseCamera();
      } catch (e) {
        // Handle any exceptions that might occur during scanItem
        print("Error during scanItem: $e");
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
