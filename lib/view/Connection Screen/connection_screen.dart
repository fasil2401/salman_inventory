import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/connection_setting_controller.dart';
import 'package:axolon_inventory_manager/controller/App%20Controls/login_controller.dart';
import 'package:axolon_inventory_manager/utils/constants/colors.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:axolon_inventory_manager/view/Login%20Screen/login_screen.dart';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:get/get.dart';
import 'package:barcode_widget/barcode_widget.dart' as barcode;

import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'components/qr_scanner.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';

class ConnectionScreen extends StatefulWidget {
  ConnectionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  var qrKey = GlobalKey();
  final loginController = Get.put(LoginController());
  final connectionSettingController = Get.put(ConnectionSettingController());

  // Future<bool> _requestStoragePermission(BuildContext context) async {
  //   PermissionStatus status = await Permission.storage.request();

  //   if (status == PermissionStatus.denied) {
  //     // If the user denies permission, show a dialog to request permission
  //    // bool userAccepted = await _showPermissionRequestDialog(context);

  //     // Return true if the user accepts the permission in the dialog
  //     //return userAccepted;
  //   }

  //   // Return true if the permission is already granted or granted during the request
  //   return status == PermissionStatus.granted;
  // }

  // Future<bool> _showPermissionRequestDialog(BuildContext context) async {
  //   return await showDialog<bool>(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text('Permission Required'),
  //             content: Text('To proceed, please grant storage permission.'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context)
  //                       .pop(false); // User chose not to grant permission
  //                 },
  //                 child: Text('Cancel'),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context)
  //                       .pop(true); // User chose to grant permission
  //                 },
  //                 child: Text('Grant Permission'),
  //               ),
  //             ],
  //           );
  //         },
  //       ) ??
  //       false; // Default to false if the dialog is dismissed
  // }

  void takeScreenShot(BuildContext context) async {
    log('Before permission request: ${await Permission.storage.status}');
    PermissionStatus status = await Permission.storage.request();
    log('After permission request: $status');

    if (status.isDenied) {
      final boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 5.0);
      final byteData = await (image.toByteData(format: ImageByteFormat.png));

      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();

        final directory = (await getApplicationDocumentsDirectory()).path;
        final imgFile = File(
          '$directory/${DateFormatter.dateFormat.format(DateTime.now()).toString()}axolonInventory.png',
        );
        imgFile.writeAsBytes(pngBytes);

        GallerySaver.saveImage(imgFile.path).then((success) async {
          Share.shareXFiles([XFile('${imgFile.path}')]);
        });
      }
    } else {
      if (status.isPermanentlyDenied) {
        // The user opted to never again see the permission request dialog.
        // Open the app settings to enable the permission manually.
        log('Storage permission is permanently denied', name: 'Permission');
        openAppSettings();
      } else {
        // Handle other cases where the permission is denied
        log('User chose not to grant storage permission', name: 'Permission');
      }
    }
  }

  // takeScreenShot() async {
  //   PermissionStatus res;
  //   res = await Permission.storage.request();
  //   print('Permission status: $res');
  //   if (res.isDenied) {

  //     final boundary =
  //         qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

  //     // We can increse the size of QR using pixel ratio
  //     //log("mmmm");
  //     final image = await boundary.toImage(pixelRatio: 5.0);
  //     final byteData = await (image.toByteData(format: ImageByteFormat.png));

  //     if (byteData != null) {
  //       final pngBytes = byteData.buffer.asUint8List();

  //       // getting directory of our phone
  //       final directory = (await getApplicationDocumentsDirectory()).path;
  //       final imgFile = File(
  //         '$directory/${DateFormatter.dateFormat.format(DateTime.now()).toString()}axolonInventory.png',
  //       );
  //       imgFile.writeAsBytes(pngBytes);
  //       //In here you can show snackbar or do something in the backend at successfull download
  //       // Share.shareXFiles([XFile('${imgFile.path}')]);
  //       GallerySaver.saveImage(imgFile.path).then((success) async {
  //         //In here you can show snackbar or do something in the backend at successfull download
  //         Share.shareXFiles([XFile('${imgFile.path}')]);
  //         // Get.snackbar(
  //         //   'QR Code',
  //         //   'QR Code saved to gallery as ${dateFormat.format(DateTime.now()).toString()}axolonInventory.png',
  //         //   duration: Duration(seconds: 2),
  //         // );
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              commonBlueColor,
              secondary,
              // commonBlueColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            /// Login & Welcome back
            Container(
              height: height * 0.2,
              padding: const EdgeInsets.only(left: 10, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  /// LOGIN TEXT
                  Text('Connection',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  SizedBox(height: 3.5),

                  /// WELCOME
                  Text('Set your connection settings',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: height * 0.03),

                                Center(
                                  child: SizedBox(
                                    width: width * 0.35,
                                    child: Image.asset(
                                        'assets/images/axolon_logo.png',
                                        fit: BoxFit.contain),
                                  ),
                                ),
                                // SizedBox(height: height * 0.035),

                                /// Text Fields
                                Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 30),
                                      child: Obx(
                                        () => RepaintBoundary(
                                          key: qrKey,
                                          child: barcode.BarcodeWidget(
                                            backgroundColor: Colors.white,
                                            barcode: barcode.Barcode.qrCode(),
                                            data: connectionSettingController
                                                .qrData.value,
                                            width: width * 0.3,
                                            height: width * 0.3,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 20),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      // height: height * 0.5,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                                blurRadius: 20,
                                                spreadRadius: 10,
                                                offset: const Offset(0, 10)),
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Visibility(
                                          //   visible: settingsList.isNotEmpty,
                                          //   child: DropdownButtonFormField2(
                                          //     isDense: true,
                                          //     dropdownFullScreen: true,
                                          //     // value: settingsList[0],
                                          //
                                          //     style: TextStyle(
                                          //       color: commonBlueColor,
                                          //       fontSize: 18,
                                          //     ),
                                          //     decoration: InputDecoration(
                                          //       isCollapsed: true,
                                          //       contentPadding:
                                          //       const EdgeInsets.symmetric(
                                          //           vertical: 15),
                                          //     ),
                                          //     hint: const Text(
                                          //       'Select Company',
                                          //       style: TextStyle(
                                          //         color: commonBlueColor,
                                          //         fontSize: 16,
                                          //       ),
                                          //     ),
                                          //     isExpanded: true,
                                          //     icon: const Icon(
                                          //       Icons.arrow_drop_down,
                                          //       color: commonBlueColor,
                                          //     ),
                                          //     iconSize: 20,
                                          //     // buttonHeight: 37,
                                          //     buttonPadding:
                                          //     const EdgeInsets.symmetric(
                                          //       horizontal: 10,
                                          //     ),
                                          //     dropdownDecoration: BoxDecoration(
                                          //       borderRadius:
                                          //       BorderRadius.circular(15),
                                          //     ),
                                          //     items: settingsList
                                          //         .map(
                                          //           (item) => DropdownMenuItem(
                                          //         value: item,
                                          //         child: Text(
                                          //           item.connectionName!,
                                          //           style: const TextStyle(
                                          //             fontSize: 16,
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     )
                                          //         .toList(),
                                          //     onChanged: (value) async {
                                          //       var settings =
                                          //       value as ConnectionModel;
                                          //       selectSettings(settings);
                                          //     },
                                          //     onSaved: (value) {},
                                          //   ),
                                          // ),
                                          SizedBox(height: height * 0.01),
                                          Stack(
                                            children: [
                                              Obx(
                                                () => buildTextField(
                                                  textInputType:
                                                      TextInputType.text,
                                                  controller:
                                                      connectionSettingController
                                                          .connectiionNameController
                                                          .value,
                                                  label: 'Connection Name',
                                                  onChanged: (connectionName) {
                                                    connectionSettingController
                                                        .getConnectionName(
                                                            connectionName);
                                                    connectionSettingController
                                                        .setConnectionName(
                                                            connectionName);
                                                  },
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10, top: 10),
                                                alignment:
                                                    Alignment.centerRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.to(() => QRScanner());
                                                  },
                                                  child: const Icon(
                                                    Icons.qr_code_rounded,
                                                    color: commonBlueColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                              color: AppColors.lightGrey,
                                              height: 0.3),
                                          Obx(
                                            () => _buildWarning(
                                                isVisible:
                                                    connectionSettingController
                                                        .nameWarning.value,
                                                text:
                                                    'Enter the connection name or scan the QR code'),
                                          ),
                                          SizedBox(height: height * 0.01),
                                          Obx(() => buildTextField(
                                                textInputType:
                                                    TextInputType.text,
                                                controller:
                                                    connectionSettingController
                                                        .ipController.value,
                                                label: 'Server IP',
                                                onChanged: (serverIp) {
                                                  // setState(() =>
                                                  //     this.serverIp = serverIp);
                                                  connectionSettingController
                                                      .getServerIp(serverIp);
                                                  connectionSettingController
                                                      .setServerIp(serverIp);
                                                },
                                              )),
                                          Divider(
                                              color: AppColors.lightGrey,
                                              height: 0.3),
                                          Obx(
                                            () => _buildWarning(
                                                isVisible:
                                                    connectionSettingController
                                                        .ipWarning.value,
                                                text: 'Enter the server IP'),
                                          ),
                                          SizedBox(height: height * 0.01),
                                          Obx(() => buildTextField(
                                                textInputType:
                                                    TextInputType.text,
                                                controller:
                                                    connectionSettingController
                                                        .portController.value,
                                                label: 'Port',
                                                onChanged: (port) {
                                                  // setState(() => this.port = port);
                                                  connectionSettingController
                                                      .getPort(port);
                                                  connectionSettingController
                                                      .setPort(port);
                                                },
                                              )),
                                          Divider(
                                              color: AppColors.lightGrey,
                                              height: 0.3),
                                          Obx(
                                            () => _buildWarning(
                                                isVisible:
                                                    connectionSettingController
                                                        .portWarning.value,
                                                text:
                                                    'Enter the  service port ex:- 0000'),
                                          ),
                                          SizedBox(height: height * 0.01),
                                          Obx(() => buildTextField(
                                                textInputType:
                                                    TextInputType.text,
                                                controller:
                                                    connectionSettingController
                                                        .dbController.value,
                                                label: 'Database Name',
                                                onChanged: (database) {
                                                  // setState(() =>
                                                  //     this.database = database);
                                                  connectionSettingController
                                                      .getDatabaseName(
                                                          database);
                                                  connectionSettingController
                                                      .setDatabase(database);
                                                },
                                              )),
                                          Divider(
                                              color: AppColors.lightGrey,
                                              height: 0.3),
                                          Obx(
                                            () => _buildWarning(
                                                isVisible:
                                                    connectionSettingController
                                                        .databaseNameWarning
                                                        .value,
                                                text:
                                                    'Enter the database name'),
                                          ),
                                          SizedBox(height: height * 0.01),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                          height: 40,
                                          // width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: buildElevatedButtonCancel(
                                              text: 'Cancel',
                                              onPressed: () {
                                                // Get.back();
                                                // Get.offAll(() =>
                                                //     ConnectionScreen());
                                                // getLocalSettings();
                                              },
                                              color: mutedBlueColor,
                                              textColor: commonBlueColor)),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        height: 40,
                                        // width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: buildElevatedButton(
                                            text: 'Continue',
                                            onPressed: () async {
                                              await connectionSettingController
                                                  .validateForm(
                                                connectionName:
                                                    connectionSettingController
                                                        .connectiionNameController
                                                        .value
                                                        .text,
                                                serverIp:
                                                    connectionSettingController
                                                        .ipController
                                                        .value
                                                        .text,
                                                port:
                                                    connectionSettingController
                                                        .portController
                                                        .value
                                                        .text,
                                                databaseName:
                                                    connectionSettingController
                                                        .dbController
                                                        .value
                                                        .text,
                                              );
                                              // log("${connectionSettingController.connectiionNameController.value.text}");
                                              await UserSimplePreferences
                                                  .setConnectionName(
                                                      connectionSettingController
                                                          .connectiionNameController
                                                          .value
                                                          .text);
                                              await UserSimplePreferences
                                                  .setServerIp(
                                                      connectionSettingController
                                                          .ipController
                                                          .value
                                                          .text);
                                              await UserSimplePreferences
                                                  .setPort(
                                                      connectionSettingController
                                                          .portController
                                                          .value
                                                          .text);
                                              await UserSimplePreferences
                                                  .setDatabase(
                                                      connectionSettingController
                                                          .dbController
                                                          .value
                                                          .text);
                                              await UserSimplePreferences
                                                  .setConnection('true');
                                              Get.to(() => LoginScreen());
                                              await connectionSettingController
                                                  .setData();
                                              Get.to(() => LoginScreen());
                                              // log("value${connectionSettingController.connectionName.value}");
                                              // await getLocalSettings();
                                              // connectionSettingController
                                              //     .saveSettings(settingsList);
                                            },
                                            color: commonBlueColor,
                                            textColor: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      child: CircleAvatar(
                                        backgroundColor: commonRedColor,
                                        radius: 20,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 18,
                                          child: Icon(
                                            Icons.delete_outline_outlined,
                                            color: commonRedColor,
                                            size: 17,
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        deleteConnection();
                                      },
                                    ),
                                    GFButton(
                                      onPressed: () {
                                        // settingsList.clear();
                                        connectionSettingController.createNew();
                                      },
                                      text: "Add New",
                                      buttonBoxShadow: true,
                                      color: commonBlueColor,
                                      icon: Icon(
                                        Icons.add,
                                        color: commonBlueColor,
                                        size: 20,
                                      ),
                                      type: GFButtonType.outline,
                                      shape: GFButtonShape.pills,
                                    ),
                                    InkWell(
                                      child: CircleAvatar(
                                        backgroundColor: success,
                                        radius: 20,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 18,
                                          child: Icon(
                                            Icons.share_outlined,
                                            color: success,
                                            size: 17,
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        // await assignControllers();
                                        await connectionSettingController
                                            .setData();
                                        takeScreenShot(context);
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AutoSizeText(
                                          'version : ${UserSimplePreferences.getVersion() ?? ''}',
                                          minFontSize: 12,
                                          maxFontSize: 16,
                                          style: TextStyle(
                                            color: mutedColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        AutoSizeText(
                                          'License : Evaluation',
                                          minFontSize: 12,
                                          maxFontSize: 16,
                                          style: TextStyle(
                                            color: mutedColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton({
    required String text,
    required VoidCallback onPressed,
    required Color color,
    required Color textColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // <-- Radius
        ),
      ),
      child: Obx(() => connectionSettingController.isLoading.value
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : Text(text, style: TextStyle(color: textColor))),
    );
  }

  ElevatedButton buildElevatedButtonCancel({
    required String text,
    required VoidCallback onPressed,
    required Color color,
    required Color textColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // <-- Radius
        ),
      ),
      child: Text(text, style: TextStyle(color: textColor)),
    );
  }

  TextField buildTextField({
    required TextEditingController controller,
    required String label,
    required Function(String value) onChanged,
    required TextInputType textInputType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: InputBorder.none,
        label: Text(
          label,
          style: TextStyle(
            color: commonBlueColor,
          ),
        ),
        isCollapsed: false,
        hintStyle: TextStyle(
          fontSize: 10,
          color: Colors.grey,
        ),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildWarning({
    required String text,
    required bool isVisible,
  }) {
    return Visibility(
      visible: isVisible,
      child: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(right: 10, top: 5),
        child: Text(
          text,
          style: TextStyle(
            color: commonRedColor,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  deleteConnection() async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Delete',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(
          'Are you Sure, You want to delete this?',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Wait',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              // await connectionSettingController
              //     .deleteConnectionSettings(connectionSettingController.connectiionNameController.value.text);
              await setPrefereces();
              connectionSettingController.createNew();
              Get.offAll(() => ConnectionScreen());
            },
            child: Text(
              'Delete',
              style: TextStyle(
                color: commonRedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  setPrefereces() async {
    await UserSimplePreferences.setUsername('');
    await UserSimplePreferences.setUserPassword('');
    await UserSimplePreferences.setConnectionName('');
    await UserSimplePreferences.setServerIp('');
    await UserSimplePreferences.setPort('');
    await UserSimplePreferences.setDatabase('');
  }
}
