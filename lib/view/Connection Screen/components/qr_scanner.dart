import 'dart:developer';
import 'dart:io';
import 'package:axolon_inventory_manager/controller/App%20Controls/connection_setting_controller.dart';
import 'package:axolon_inventory_manager/view/Connection%20Screen/connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final connectionSettingController = Get.put(ConnectionSettingController());
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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

  @override
  Widget build(BuildContext context) {
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
          alignment: Alignment.bottomCenter,
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
                onPressed: () async {
                  await connectionSettingController.getImage();
                  var result = await Scan.parse(
                      connectionSettingController.image.value.path);
                  controller?.pauseCamera();
                  connectionSettingController.prefilData(result);
                  Get.off(() => ConnectionScreen());
                },
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.image_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
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
                  Get.back();
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

  _onQRViewCreated(QRViewController controller) async {
    controller.resumeCamera();
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      print('=======================${result!.code}');
      controller.pauseCamera();
      connectionSettingController.prefilData(result!.code);
      Get.off(() => ConnectionScreen());
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
