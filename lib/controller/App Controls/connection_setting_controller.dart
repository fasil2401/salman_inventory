import 'dart:convert';
import 'dart:developer';

import 'package:axolon_inventory_manager/model/connection_qr_model.dart';
import 'package:axolon_inventory_manager/utils/Encryption/encryptor.dart';
import 'package:axolon_inventory_manager/utils/date_formatter.dart';
import 'package:axolon_inventory_manager/utils/package_info/package_info.dart';
import 'package:axolon_inventory_manager/utils/shared_preferences/shared_preferneces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ConnectionSettingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    prefilData('');
  }

  var qrCode = ''.obs;

  var packageInfo = {}.obs;
  var image = XFile("").obs;
  var nameWarning = false.obs;
  var ipWarning = false.obs;
  var portWarning = false.obs;
  var databaseNameWarning = false.obs;
  var isLoading = false.obs;
  var qrData = ''.obs;
  var connectionName = ''.obs;
  var serverIp = ''.obs;
  var port = ''.obs;
  var database = ''.obs;
  var connectiionNameController = TextEditingController().obs;
  var ipController = TextEditingController().obs;
  var portController = TextEditingController().obs;
  var dbController = TextEditingController().obs;
  var encryptedServerIp = ''.obs;
  var encryptedPort = ''.obs;
  var encryptedDatabase = ''.obs;
  var encryptedConnectionName = ''.obs;

  Future init() async {
    final packageInfo = await PackageInfoApi.getInfo();

    final newPackageInfo = {
      ...packageInfo,
    };
    this.packageInfo.value = newPackageInfo;
    update();
  }

  Future getImage() async {
    final images = await ImagePicker().pickImage(source: ImageSource.gallery);
    image.value = images!;
  }

  setData() async {
    // await connectionSettingController.validateForm();
    await getConnectionName(connectiionNameController.value.text);
    await getServerIp(ipController.value.text);
    await getPort(portController.value.text);
    await getDatabaseName(dbController.value.text);
  }

  getConnectionName(String connectionName) {
    if (connectionName.isEmpty) {
      nameWarning.value = true;
    } else {
      nameWarning.value = false;
    }
    this.connectionName.value = connectionName;
    encryptedConnectionName.value = EncryptData.encryptAES(connectionName);
    getQrData();
  }

  getServerIp(String serverIp) {
    if (serverIp.isEmpty) {
      ipWarning.value = true;
    } else {
      ipWarning.value = false;
    }
    this.serverIp.value = serverIp;
    encryptedServerIp.value = EncryptData.encryptAES(serverIp);
    getQrData();
  }

  getPort(String port) {
    if (port.isEmpty) {
      portWarning.value = true;
    } else {
      portWarning.value = false;
    }
    this.port.value = port;
    encryptedPort.value = EncryptData.encryptAES(port);
    getQrData();
  }

  getDatabaseName(String databaseName) {
    if (databaseName.isEmpty) {
      databaseNameWarning.value = true;
    } else {
      databaseNameWarning.value = false;
    }
    this.database.value = databaseName;
    encryptedDatabase.value = EncryptData.encryptAES(databaseName);
    getQrData();
    // getHttpPort(databaseName);
  }

  setServerIp(String serverIp) async {
    this.serverIp.value = serverIp;
    if (serverIp.isNotEmpty) {
      encryptedServerIp.value = EncryptData.encryptAES(serverIp);
      await setQrCode();
    }
  }

  setPort(String port) async {
    this.port.value = port;
    if (port.isNotEmpty) {
      encryptedPort.value = EncryptData.encryptAES(port);
      await setQrCode();
    }
  }

  setDatabase(String database) async {
    this.database.value = database;
    if (database.isNotEmpty) {
      encryptedDatabase.value = EncryptData.encryptAES(database);
      await setQrCode();
    }
  }

  setConnectionName(String connectionName) async {
    this.connectionName.value = connectionName;
    if (encryptedConnectionName.isNotEmpty) {
      encryptedConnectionName.value = EncryptData.encryptAES(connectionName);
      await setQrCode();
    }
  }

  createNew() async {
    connectiionNameController.value.text = '';
    ipController.value.text = '';
    portController.value.text = '';
    dbController.value.text = '';
    update();
  }

  fillDataOnScan(jsonDatas) async {
    var jsonData = connectionQrModelFromJson(jsonDatas);
    var decryptedData = EncryptData.decryptAES(jsonData.connectionName);
    var serverIp = EncryptData.decryptAES(jsonData.serverIp);
    var serverPort = EncryptData.decryptAES(jsonData.port);
    var database = EncryptData.decryptAES(jsonData.databaseName);

    connectiionNameController.value.text = decryptedData;
    ipController.value.text = serverIp;
    portController.value.text = serverPort;
    dbController.value.text = database;
    update();
    await setConnectionName(connectiionNameController.value.text);
    await setServerIp(ipController.value.text);
    await setPort(portController.value.text);
    await setDatabase(dbController.value.text);
  }

  prefilData(var jsonData) async {
    if (jsonData != '') {
      fillDataOnScan(jsonData);
      // } else if (widget.connectionModel != null) {
      //   setState(() {
      //     connectiionNameController.value.text =
      //         widget.connectionModel!.connectionName ?? '';
      //     ipController.value.text = widget.connectionModel!.serverIp ?? '';
      //     portController.value.text = widget.connectionModel!.port ?? '';
      //     dbController.value.text = widget.connectionModel!.databaseName ?? '';
      //   });
    } else {
      String connectionName =
          await UserSimplePreferences.getConnectionName() ?? '';
      String serverIp = await UserSimplePreferences.getServerIp() ?? '';
      String port = await UserSimplePreferences.getPort() ?? '';
      String databaseName = await UserSimplePreferences.getDatabase() ?? '';
      connectiionNameController.value.text = connectionName;
      ipController.value.text = serverIp;
      portController.value.text = port;
      dbController.value.text = databaseName;
      update();
      // }
    }
  }

  setQrCode() {
    qrCode.value = jsonEncode({
      "Instance": encryptedServerIp.value,
      "DbName": encryptedDatabase.value,
      "Port": encryptedPort.value,
    });
  }

  getQrData() {
    qrData.value = jsonEncode({
      "connectionName": encryptedConnectionName.value,
      "serverIp": encryptedServerIp.value,
      "port": encryptedPort.value,
      "databaseName": encryptedDatabase.value,
    });
  }

  validateForm({
    required String connectionName,
    required String serverIp,
    required String port,
    required String databaseName,
  }) {
    if (connectionName.isEmpty) {
      nameWarning.value = true;
    } else {
      nameWarning.value = false;
    }
    if (serverIp.isEmpty) {
      ipWarning.value = true;
    } else {
      ipWarning.value = false;
    }
    if (port.isEmpty) {
      portWarning.value = true;
    } else {
      portWarning.value = false;
    }
    if (databaseName.isEmpty) {
      databaseNameWarning.value = true;
    } else {
      databaseNameWarning.value = false;
    }
  }
}